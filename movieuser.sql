
-- movie, review 조인
-- mno, title, regdate(movie)
-- review 수, 평균(review)

SELECT m.MNO, m.title, m.REGDATE, avg(r.GRADE), count(r.RNO)
FROM MOVIE m LEFT JOIN REVIEW r ON m.MNO = r.MOVIE_MNO GROUP BY m.MNO, m.title, m.REGDATE;


SELECT r.MOVIE_MNO, avg(r.GRADE), COUNT(r.grade)
FROM REVIEW r 
GROUP BY r.MOVIE_MNO;


SELECT
	m.MNO, m.TITLE , review.MOVIE_MNO, review.avg, review.count, REGDATE
FROM
	MOVIE m
LEFT JOIN (
	SELECT
		r.MOVIE_MNO AS MOVIE_MNO,
		avg(r.GRADE) AS avg,
		COUNT(r.grade) AS count
	FROM
		REVIEW r
	GROUP BY
		r.MOVIE_MNO) review ON
	m.MNO = review.MOVIE_MNO;
	

-- movie, review 서브쿼리

SELECT
	m.MNO,
	m.TITLE,
	m.REGDATE,
	(
	SELECT
		avg(r.GRADE)
	FROM
		REVIEW r
	WHERE
		r.movie_mno = m.MNO) avg,
	(
	SELECT
		COUNT(r.RNO)
	FROM
		REVIEW r
	WHERE
		r.movie_mno = m.MNO) cnt
FROM
	MOVIE m;



-- movie, review, movie_image 조인 or 서브쿼리
-- mno, title, regdate(movie)
-- review 수, 평균(review)
-- inum, path, uuid, img_name    max(inum) 기준 movie_mno

SELECT
	m.MNO,
	m.TITLE,
	m.REGDATE,
	(
	SELECT
		avg(r.GRADE)
	FROM
		REVIEW r
	WHERE
		r.movie_mno = m.MNO) avg,
	(
	SELECT
		COUNT(r.RNO)
	FROM
		REVIEW r
	WHERE
		r.movie_mno = m.MNO) cnt, mi2 IMG_NAME, mi2.INUM, mi2."PATH", mi2.UUID 
FROM
	MOVIE m LEFT JOIN MOVIE_IMAGE mi2 ON m.MNO = mi2.MOVIE_MNO 
WHERE mi2.inum IN (SELECT max(mi.inum) FROM MOVIE_IMAGE mi GROUP BY mi.movie_mno);
