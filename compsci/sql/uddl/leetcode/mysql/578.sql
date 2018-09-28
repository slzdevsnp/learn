drop table survey_log;
Create table survey_log (uid int, action varchar(10), question_id int, answer_id int, q_num int, timestamp int);
insert into survey_log (uid, action, question_id, answer_id, q_num, timestamp) values ('5', 'show', '285', NULL, '1', '123');
insert into survey_log (uid, action, question_id, answer_id, q_num, timestamp) values ('5', 'answer', '285', '124124', '1', '124');
insert into survey_log (uid, action, question_id, answer_id, q_num, timestamp) values ('5', 'show', '369', NULL, '2', '125');
insert into survey_log (uid, action, question_id, answer_id, q_num, timestamp) values ('5', 'skip', '369', NULL, '2', '126');
