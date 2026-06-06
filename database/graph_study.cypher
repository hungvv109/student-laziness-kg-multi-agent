// 1. Áp lực gia đình -> Chọn sai ngành
MERGE (a:VanDe {name: 'Áp lực gia đình'}) MERGE (b:VanDe {name: 'Chọn sai ngành'}) MERGE (a)-[:DAN_DEN]->(b);

// 2. Chọn sai ngành -> Mất hứng thú học tập
MERGE (a:VanDe {name: 'Chọn sai ngành'}) MERGE (b:VanDe {name: 'Mất hứng thú học tập'}) MERGE (a)-[:GAY_RA]->(b);

// 3. Mất hứng thú học tập -> Trì hoãn
MERGE (a:VanDe {name: 'Mất hứng thú học tập'}) MERGE (b:VanDe {name: 'Trì hoãn'}) MERGE (a)-[:LAM_TANG]->(b);

// 4. Không thấy ý nghĩa môn học -> Chán nản
MERGE (a:VanDe {name: 'Không thấy ý nghĩa môn học'}) MERGE (b:VanDe {name: 'Chán nản'}) MERGE (a)-[:GAY_RA]->(b);

// 5. Chán nản -> Lười học
MERGE (a:VanDe {name: 'Chán nản'}) MERGE (b:VanDe {name: 'Lười học'}) MERGE (a)-[:DAN_DEN]->(b);

// 6. Mất định hướng nghề nghiệp -> Động lực học tập
MERGE (a:VanDe {name: 'Mất định hướng nghề nghiệp'}) MERGE (b:VanDe {name: 'Động lực học tập'}) MERGE (a)-[:LAM_GIAM]->(b);

// 7. Lịch học dày đặc -> Quá tải
MERGE (a:VanDe {name: 'Lịch học dày đặc'}) MERGE (b:VanDe {name: 'Quá tải'}) MERGE (a)-[:GAY_RA]->(b);

// 8. Làm thêm nhiều -> Mệt mỏi
MERGE (a:VanDe {name: 'Làm thêm nhiều'}) MERGE (b:VanDe {name: 'Mệt mỏi'}) MERGE (a)-[:LAM_TANG]->(b);

// 9. Deadline liên tục -> Căng thẳng
MERGE (a:VanDe {name: 'Deadline liên tục'}) MERGE (b:VanDe {name: 'Căng thẳng'}) MERGE (a)-[:DAN_DEN]->(b);

// 10. Quá tải -> Kiệt sức
MERGE (a:VanDe {name: 'Quá tải'}) MERGE (b:VanDe {name: 'Kiệt sức'}) MERGE (a)-[:GAY_RA]->(b);

// 11. Kiệt sức -> Khả năng tập trung
MERGE (a:VanDe {name: 'Kiệt sức'}) MERGE (b:VanDe {name: 'Khả năng tập trung'}) MERGE (a)-[:LAM_GIAM]->(b);

// 12. Mệt mỏi -> Né tránh học tập
MERGE (a:VanDe {name: 'Mệt mỏi'}) MERGE (b:VanDe {name: 'Né tránh học tập'}) MERGE (a)-[:DAN_DEN]->(b);

// 13. Né tránh học tập -> Lười học
MERGE (a:VanDe {name: 'Né tránh học tập'}) MERGE (b:VanDe {name: 'Lười học'}) MERGE (a)-[:BIEU_HIEN_THANH]->(b);

// 14. So sánh bạn bè -> Tự ti
MERGE (a:VanDe {name: 'So sánh bạn bè'}) MERGE (b:VanDe {name: 'Tự ti'}) MERGE (a)-[:GAY_RA]->(b);

// 15. Tự ti -> Sợ thất bại
MERGE (a:VanDe {name: 'Tự ti'}) MERGE (b:VanDe {name: 'Sợ thất bại'}) MERGE (a)-[:LAM_TANG]->(b);

// 16. Sợ thất bại -> Né tránh học tập
MERGE (a:VanDe {name: 'Sợ thất bại'}) MERGE (b:VanDe {name: 'Né tránh học tập'}) MERGE (a)-[:DAN_DEN]->(b);

// 17. Thiếu nền tảng kiến thức -> Khó hiểu bài
MERGE (a:VanDe {name: 'Thiếu nền tảng kiến thức'}) MERGE (b:VanDe {name: 'Khó hiểu bài'}) MERGE (a)-[:GAY_RA]->(b);

// 18. Khó hiểu bài -> Cảm giác bất lực
MERGE (a:VanDe {name: 'Khó hiểu bài'}) MERGE (b:VanDe {name: 'Cảm giác bất lực'}) MERGE (a)-[:LAM_TANG]->(b);

// 19. Cảm giác bất lực -> Động lực học tập
MERGE (a:VanDe {name: 'Cảm giác bất lực'}) MERGE (b:VanDe {name: 'Động lực học tập'}) MERGE (a)-[:LAM_GIAM]->(b);

// 20. Sợ bị đánh giá -> Không hỏi bài
MERGE (a:VanDe {name: 'Sợ bị đánh giá'}) MERGE (b:VanDe {name: 'Không hỏi bài'}) MERGE (a)-[:DAN_DEN]->(b);

// 21. Không hỏi bài -> Hổng kiến thức
MERGE (a:VanDe {name: 'Không hỏi bài'}) MERGE (b:VanDe {name: 'Hổng kiến thức'}) MERGE (a)-[:LAM_TANG]->(b);

// 22. Mạng xã hội -> Xao nhãng
MERGE (a:VanDe {name: 'Mạng xã hội'}) MERGE (b:VanDe {name: 'Xao nhãng'}) MERGE (a)-[:GAY_RA]->(b);

// 23. Game online -> Trì hoãn
MERGE (a:VanDe {name: 'Game online'}) MERGE (b:VanDe {name: 'Trì hoãn'}) MERGE (a)-[:LAM_TANG]->(b);

// 24. Xao nhãng -> Thời gian học
MERGE (a:VanDe {name: 'Xao nhãng'}) MERGE (b:VanDe {name: 'Thời gian học'}) MERGE (a)-[:LAM_GIAM]->(b);

// 25. Thiếu kỷ luật cá nhân -> Học không đều
MERGE (a:VanDe {name: 'Thiếu kỷ luật cá nhân'}) MERGE (b:VanDe {name: 'Học không đều'}) MERGE (a)-[:DAN_DEN]->(b);

// 26. Học không đều -> Dồn bài trước thi
MERGE (a:VanDe {name: 'Học không đều'}) MERGE (b:VanDe {name: 'Dồn bài trước thi'}) MERGE (a)-[:GAY_RA]->(b);

// 27. Dồn bài trước thi -> Áp lực thi cử
MERGE (a:VanDe {name: 'Dồn bài trước thi'}) MERGE (b:VanDe {name: 'Áp lực thi cử'}) MERGE (a)-[:LAM_TANG]->(b);

// 28. Phần thưởng tức thì -> Kiên nhẫn học tập
MERGE (a:VanDe {name: 'Phần thưởng tức thì'}) MERGE (b:VanDe {name: 'Kiên nhẫn học tập'}) MERGE (a)-[:LAM_GIAM]->(b);

// 29. Trì hoãn -> Lười học
MERGE (a:VanDe {name: 'Trì hoãn'}) MERGE (b:VanDe {name: 'Lười học'}) MERGE (a)-[:BIEU_HIEN_THANH]->(b);

// 30. Phương pháp giảng dạy khô khan -> Mất hứng thú học tập
MERGE (a:VanDe {name: 'Phương pháp giảng dạy khô khan'}) MERGE (b:VanDe {name: 'Mất hứng thú học tập'}) MERGE (a)-[:GAY_RA]->(b);

// 31. Thiếu ví dụ thực tế -> Khả năng liên hệ
MERGE (a:VanDe {name: 'Thiếu ví dụ thực tế'}) MERGE (b:VanDe {name: 'Khả năng liên hệ'}) MERGE (a)-[:LAM_GIAM]->(b);

// 32. Chương trình lỗi thời -> Không thấy ý nghĩa môn học
MERGE (a:VanDe {name: 'Chương trình lỗi thời'}) MERGE (b:VanDe {name: 'Không thấy ý nghĩa môn học'}) MERGE (a)-[:DAN_DEN]->(b);

// 33. Không thấy ý nghĩa môn học -> Chán nản (Lặp lại logic ở số 4, nhưng giữ nguyên để MERGE xử lý)
MERGE (a:VanDe {name: 'Không thấy ý nghĩa môn học'}) MERGE (b:VanDe {name: 'Chán nản'}) MERGE (a)-[:GAY_RA]->(b);

// 34. Chán nản -> Chủ động học tập
MERGE (a:VanDe {name: 'Chán nản'}) MERGE (b:VanDe {name: 'Chủ động học tập'}) MERGE (a)-[:LAM_GIAM]->(b);

// 35. Thiếu dự án thực hành -> Động lực học tập
MERGE (a:VanDe {name: 'Thiếu dự án thực hành'}) MERGE (b:VanDe {name: 'Động lực học tập'}) MERGE (a)-[:LAM_GIAM]->(b);

// 36. Mất hứng thú học tập -> Lười học
MERGE (a:VanDe {name: 'Mất hứng thú học tập'}) MERGE (b:VanDe {name: 'Lười học'}) MERGE (a)-[:DAN_DEN]->(b);