-- 1 c
-- 2 tema
-- 3 tema

-- 4
SELECT *
    FROM
        (
            SELECT
                T.CATEGORY
              , COUNT(*)              NR_EX
              , count(DISTINCT TITLE) NR_TITLURI
                FROM
                    RENTAL         R
                        JOIN TITLE T ON R.TITLE_ID = T.TITLE_ID
                GROUP BY T.CATEGORY
                ORDER BY 2 DESC)
    WHERE
        ROWNUM = 1;
-- 5
SELECT
    count(COPY_ID)
  , TITLE_ID
    FROM
        TITLE_COPY
    WHERE
        STATUS = 'AVAILABLE'
    GROUP BY
        TITLE_ID;

-- 6 ?
SELECT
    T.TITLE
  , C.COPY_ID
  , STATUS
  , CASE WHEN ACT_RET_DATE IS NULL THEN 'RENTED' ELSE 'AVAILABLE' END STATUS_BUN
    FROM
        TITLE_COPY C
      , TITLE      T
      , RENTAL     R
    WHERE
          C.TITLE_ID = T.TITLE_ID
      AND C.TITLE_ID = R.TITLE_ID
      AND C.COPY_ID = R.COPY_ID;
SELECT
    ACT_RET_DATE
    FROM
        RENTAL;

-- 7 ?
SELECT *
    FROM
        (SELECT
             C.TITLE_ID                                                        TID
           , C.COPY_ID                                                         ID
           , CASE WHEN ACT_RET_DATE IS NULL THEN 'RENTED' ELSE 'AVAILABLE' END STATUS_BUN
             FROM
                 TITLE_COPY C
               , RENTAL     R
             WHERE
                   C.COPY_ID = R.COPY_ID
               AND C.TITLE_ID = R.TITLE_ID) STAT_BUN
      , RENTAL                              R
      , TITLE_COPY                          T
    WHERE
          STAT_BUN.ID = R.COPY_ID
      AND STAT_BUN.ID = T.COPY_ID
      AND R.TITLE_ID = STAT_BUN.TID
      AND TID = T.TITLE_ID
      AND T.STATUS <> STAT_BUN.STATUS_BUN;

SELECT *
    FROM
        RENTAL;

-- 8
SELECT
    decode(count(*), 0, 'DA', 'NU')
    FROM
        (SELECT
             TITLE_ID
           , CASE WHEN (RES_DATE, MEMBER_ID, TITLE_ID) IN (SELECT BOOK_DATE, MEMBER_ID, TITLE_ID FROM RENTAL)
                      THEN 'DA'
                      ELSE 'NU'
             END INFO
             FROM
                 RESERVATION)
    WHERE
        INFO = 'NU';

-- 9
SELECT
    LAST_NAME
  , MEMBER.FIRST_NAME
  , T.TITLE
  , count(DISTINCT T.TITLE_ID)
    FROM
        MEMBER
      , RENTAL
      , TITLE T
    WHERE
          MEMBER.MEMBER_ID = RENTAL.MEMBER_ID
      AND RENTAL.TITLE_ID = T.TITLE_ID
    GROUP BY
        (LAST_NAME, FIRST_NAME, T.TITLE);

-- 10
SELECT
    LAST_NAME
  , MEMBER.FIRST_NAME
  , T.TITLE_ID
  , RENTAL.COPY_ID
  , count(*)
    FROM
        MEMBER
      , RENTAL
      , TITLE T
    WHERE
          MEMBER.MEMBER_ID = RENTAL.MEMBER_ID
      AND RENTAL.TITLE_ID = T.TITLE_ID
    GROUP BY
        (LAST_NAME, FIRST_NAME, T.TITLE_ID, RENTAL.COPY_ID)
    ORDER BY
        1, 2, 3, 4;

-- 11 tema
SELECT DISTINCT
    TITLE
  , OUT.TITLE_ID
  , regexp_substr((SELECT
                       max(count(MEMBER_ID) || 'copie:' || COPY_ID)
                       FROM
                           RENTAL INN
                       WHERE
                           OUT.TITLE_ID = INN.TITLE_ID
                       GROUP BY COPY_ID
                  ), '\d+', 1, 2) COPIE
  , regexp_substr((SELECT
                       max(count(MEMBER_ID) || 'copie:' || COPY_ID)
                       FROM
                           RENTAL INN
                       WHERE
                           OUT.TITLE_ID = INN.TITLE_ID
                       GROUP BY COPY_ID
                  ), '\d+', 1, 1) NR_IMP
  , STATUS
    FROM
        RENTAL OUT
      ,        TITLE_COPY
      ,        TITLE
    WHERE
            regexp_substr((SELECT
                               max(count(MEMBER_ID) || 'copie:' || COPY_ID)
                               FROM
                                   RENTAL INN
                               WHERE
                                   OUT.TITLE_ID = INN.TITLE_ID
                               GROUP BY COPY_ID
                          ), '\d+', 1, 2) = TITLE_COPY.COPY_ID
      AND   OUT.TITLE_ID = TITLE_COPY.TITLE_ID
      AND   OUT.TITLE_ID = TITLE.TITLE_ID;


-- 12 tema
SELECT
    extract(DAY FROM BOOK_DATE) ZI
  , count(*)                    IMPRUMUTURI
    FROM
        RENTAL
    WHERE
          extract(MONTH FROM BOOK_DATE) = extract(MONTH FROM sysdate)
      AND extract(DAY FROM BOOK_DATE) IN (1, 2)
    GROUP BY
        BOOK_DATE;
SELECT
    extract(DAY FROM BOOK_DATE) ZI
  , count(*)                    IMPRUMUTURI
    FROM
        RENTAL
    WHERE
        extract(MONTH FROM BOOK_DATE) = extract(MONTH FROM sysdate)
    GROUP BY
        BOOK_DATE;

SELECT
    ZI
  , sum(NR) NUMAR
    FROM
        (
            SELECT
                to_number(to_char(BOOK_DATE, 'dd')) ZI
              , count(*)                            NR
                FROM
                    RENTAL
                WHERE
                    extract(MONTH FROM BOOK_DATE) = extract(MONTH FROM sysdate)
                GROUP BY to_number(to_char(BOOK_DATE, 'dd'))
            UNION
            SELECT
                LEVEL
              , 0
                FROM
                    DUAL
                  , RENTAL
                CONNECT BY
                    LEVEL < to_number(extract(DAY FROM last_day(RENTAL.BOOK_DATE))))
    GROUP BY
        ZI
    ORDER BY
        ZI;
