### Exam Predictions Analysis

Project Progress

✅ Analysis

❌ Visualization / Power BI

Tools Used for this analysis

- LLM: Such as Claude AI, Comet Browser(LLM Integrated Browser)
- VSCode
- PostgreSQL

Knowledge Used:

Basic Stats

Basic Maths

Analysis Objectives:

1. Identify how many students ✅
2. Identify numbers of genders ✅
3. Identify how many students per college ✅ 
4. Identify key factors of Good and Bad Grades ✅ 
5. Is there a correlation between grades and gender ✅
6. What is the most optimal sleep hours and study hours that would give a passing grade ❌
7. Identify whether the difficulty of exam has some effects to the results of exam scores of students ✅

Analysis Results (Not Yet Fully Finished)

## How many students are in each course?

```sql
SELECT 
    course,
    COUNT(course) AS Student_Enrolled
FROM
    exams_predictions
GROUP BY
    course
```

There are 20,000 Students in this analysis
