import streamlit as st
import os
import re
from dotenv import load_dotenv
from typing import TypedDict, Optional
from langgraph.graph import StateGraph, END
from langchain_google_genai import ChatGoogleGenerativeAI
from neo4j import GraphDatabase

# STREAMLIT
load_dotenv()
st.set_page_config(page_title="AI Tâm Lý Học Đường", page_icon="🧠", layout="centered")
st.title("🧠 Trợ Lý AI Tâm Lý Học Đường")
st.caption("Hệ thống tư vấn ứng dụng Knowledge Graph & Multi-Agent")

# BACKEND (KNOWLEDGE GRAPH)
os.getenv("GOOGLE_API_KEY")
llm = ChatGoogleGenerativeAI(model="gemini-2.5-flash", temperature=0)

URI = os.getenv("NEO4J_URI")
AUTH = (os.getenv("NEO4J_USERNAME"), os.getenv("NEO4J_PASSWORD"))

@st.cache_resource
def get_neo4j_driver():
    return GraphDatabase.driver(URI, auth=AUTH)

def execute_neo4j_query(query: str) -> str:
    try:
        driver = get_neo4j_driver()
        records, _, _ = driver.execute_query(query, database_="neo4j")
        if not records:
            return "Không tìm thấy dữ liệu liên quan trong đồ thị."
        return str([str(r.values()) for r in records])
    except Exception as e:
        return f"Lỗi truy xuất: {str(e)}"

# LANGGRAPH
class GraphState(TypedDict):
    user_input: str
    intent: str
    cypher_query: Optional[str]
    graph_data: Optional[str]
    final_response: Optional[str]

def node_router(state: GraphState) -> GraphState:
    prompt = f"""Câu hỏi: "{state['user_input']}"
    Nếu câu hỏi than vãn về tâm lý, lười học, mệt mỏi, áp lực, trả lời: "GRAPH".
    Nếu chỉ là chào hỏi, cảm ơn, trả lời: "CHAT". Chỉ trả lời 1 chữ."""
    response = llm.invoke(prompt)
    return {"intent": response.content.strip().upper()}

def node_cypher_gen(state: GraphState) -> GraphState:
    prompt = f"""Bạn là chuyên gia Neo4j. Viết lệnh Cypher để tìm nguyên nhân gốc rễ (sâu 1-3 bước) dẫn đến vấn đề người dùng đang gặp.
    Schema: (n:VanDe {{name: "Tên vấn đề"}})
    Quan hệ: [:GAY_RA], [:DAN_DEN], [:LAM_TANG], [:LAM_GIAM], [:BIEU_HIEN_THANH]
    Câu hỏi: "{state['user_input']}"
    Chỉ trả về mã Cypher, không markdown."""
    response = llm.invoke(prompt)
    clean_cypher = re.sub(r'^```cypher\n|```$', '', response.content.strip(), flags=re.MULTILINE).strip()
    return {"cypher_query": clean_cypher}

def node_execute(state: GraphState) -> GraphState:
    data = execute_neo4j_query(state['cypher_query'])
    return {"graph_data": data}

def node_counselor(state: GraphState) -> GraphState:
    if state.get("intent") == "CHAT":
        prompt = f"Người dùng nói: '{state['user_input']}'. Đóng vai chuyên gia tâm lý chào hỏi lại thật tự nhiên."
    else:
        prompt = f"""Sinh viên gặp vấn đề: "{state['user_input']}"
        Dữ liệu chuỗi nguyên nhân từ đồ thị: {state['graph_data']}
        Dựa vào dữ liệu đồ thị, hãy trấn an và đưa ra lời khuyên thực tế ngắn gọn, thấu cảm để cắt đứt chuỗi tâm lý này. Trình bày đẹp bằng markdown."""
    response = llm.invoke(prompt)
    return {"final_response": response.content}

def route_logic(state: GraphState) -> str:
    return "cypher_gen" if state["intent"] == "GRAPH" else "counselor"

# Compile luồng DAG
workflow = StateGraph(GraphState)
workflow.add_node("router", node_router)
workflow.add_node("cypher_gen", node_cypher_gen)
workflow.add_node("execute", node_execute)
workflow.add_node("counselor", node_counselor)
workflow.set_entry_point("router")
workflow.add_conditional_edges("router", route_logic)
workflow.add_edge("cypher_gen", "execute")
workflow.add_edge("execute", "counselor")
workflow.add_edge("counselor", END)
app = workflow.compile()

# FRONTEND
if "messages" not in st.session_state:
    st.session_state.messages = []

for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

# Input user
if prompt := st.chat_input("Hãy chia sẻ vấn đề bạn đang gặp phải..."):
    
    st.session_state.messages.append({"role": "user", "content": prompt})
    with st.chat_message("user"):
        st.markdown(prompt)

    with st.chat_message("assistant"):
        with st.status("🧠 Các Agent đang phân tích đồ thị...", expanded=True) as status:
            st.write("📍 Agent 1 (Router): Đang phân tích ý định...")
            
            # Run LangGraph
            initial_state = {"user_input": prompt}
            
            try:
                final_state = app.invoke(initial_state)
                
                if final_state.get("intent") == "GRAPH":
                    st.write("⚙️ Agent 2 (Text2Cypher): Đang tạo lệnh truy xuất nguyên nhân...")
                    st.code(final_state.get("cypher_query"), language="cypher")
                    st.write("🔍 Agent 3 (Graph Exec): Đang trích xuất từ Neo4j...")
                
                st.write("💡 Agent 4 (Counselor): Đang tổng hợp lời khuyên...")
                status.update(label="Finish!", state="complete", expanded=False)
                
                response_text = final_state["final_response"]
            
            except Exception as e:
                status.update(label="Error!!", state="error")
                response_text = f"Hệ thống gặp sự cố: {str(e)}"
        
        # Show final result
        st.markdown(response_text)
    
    # Save text of AI into history
    st.session_state.messages.append({"role": "assistant", "content": response_text})