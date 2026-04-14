
# cohort_analysis

Cohort Retention Analysis
SQL Project — Online Retail Dataset
What is this project?
This project answers one simple business question:
"After a customer buys from us for the first time — do they come back?"
Using only SQL, I analyzed real transaction data from an online retail store (Dec 2010 to Dec
2011). I grouped customers by the month they first purchased (called a cohort), then tracked
how many of them returned each month after that.
The final result is a retention table — a number that tells us: out of 100 customers who joined in
January, how many came back in February, March, April... and so on.
The Dataset
The data used is the UCI Online Retail Dataset — a real-world e-commerce dataset from a UK-
based store.
Dataset UCI Online Retail Dataset
Time period December 2010 — December 2011
Key columns CustomerID, InvoiceDate, InvoiceNo, Quantity, UnitPrice
Total cohorts 13 monthly cohorts analyzed
SQL tool PostgreSQL
How It Works — In Simple Words
Here is how I built the analysis step by step, explained without jargon:
Step 1 — Find when each customer first bought
I used MIN(InvoiceDate) to find the earliest purchase date for every customer. This tells us:
"When did this person start?"
Step 2 — Group customers by their joining month
I used DATE_TRUNC('month', ...) to convert exact dates into just the month. So customers who
first bought on Jan 3, Jan 15, Jan 27 all belong to the "January cohort."
Step 3 — Attach the joining month to every transaction
Using a window function (MIN OVER PARTITION BY), I added each customer's joining month
to all their future transactions — not just the first one. Now every row in the data knows both
when the customer joined AND when they purchased.
Step 4 — Calculate how many months later they returned
I used AGE() and EXTRACT(MONTH) to calculate the gap between the joining month and the
purchase month. So if someone joined in January and bought again in March, that gap is 2
months.
Step 5 — Count returning users and calculate percentage
I grouped the data by cohort month and month gap, then counted unique customers. Finally, I
divided by the original cohort size to get the retention percentage.
Results — Cohort Summary
Cohort Users
Joined
Month 1
Return
Month 3
Return
Best
Month
Key Insight
Dec 2010 948 users 38.2% 38.7% 50% (M11) Strongest cohort — loyalty grows
over time
Jan 2011 421 users 24.0% 24.2% 36.8%
(M10)
Steady mid-range performers
Feb 2011 380 users 24.7% 27.9% 31.3%
(M9)
Decent retention, dropped at end
Mar 2011 440 users 19.1% 21.8% 28.9%
(M8)
Started slow, recovered slightly
Jun 2011 235 users 20.9% 27.2% 33.6%
(M5)
Small cohort, surprisingly strong at
M5
Aug 2011 167 users 25.1% 25.1% 25.1%
(M1-3)
Smallest cohort, consistent but low
Sep 2011 298 users 29.9% 12.1% 32.6%
(M2)
Recovered from mid-year slump
Nov 2011 321 users 13.4% N/A 13.4%
(M1)
Too recent — limited data
Key Insights
Insight 1 — December 2010 is the power cohort
This cohort had 948 users — the largest of all 13 cohorts. What makes it truly special is that its
retention actually increases over time, reaching 50% by month 11. This means half the
customers who joined in December 2010 were still buying almost a year later. These are the
store's most loyal, long-term customers.
Insight 2 — Month 1 churn is the biggest problem
Across every single cohort, the biggest drop always happens in month 1. Customers go from
100% to roughly 20–38% in just one month. This means 60–80% of new customers never come
back after their first purchase. From a business perspective, this is where the most value can be
recovered — through better onboarding, welcome emails, or follow-up discounts.
Insight 3 — Mid-2011 was the weakest period
The June, July, and August 2011 cohorts were not only the smallest (167–235 users) but also
had lower long-term retention. This could indicate a seasonal slowdown, lower marketing
quality, or that the customers acquired during this period were less engaged with the brand.
Insight 4 — September 2011 shows recovery
After the mid-year slump, the September cohort bounced back to 298 users and showed
improved month-1 retention of 29.9%. This suggests either a seasonal demand pickup (holiday
season approaching) or a better customer acquisition strategy resuming.
Insight 5 — Loyal customers exist in every cohort
Users who survive past month 3 tend to stabilize around 20–30% retention for the rest of the
year. This means there is a core loyal base in every cohort. The business should identify what
these customers have in common and use that to improve early-stage retention.
Business Value of This Analysis
Cohort retention analysis is one of the most important metrics for any subscription or e-
commerce business. Here is why this project matters:
• Retention rate directly predicts long-term revenue and customer lifetime value (LTV)
• Month-1 drop rate shows where the business is losing the most customers — fixing this
has the highest ROI
• Cohort comparison reveals whether newer customers behave differently from older ones
• Seasonal patterns in cohort size help plan marketing and inventory budgets
• This type of analysis is regularly used by analysts at companies like Amazon, Flipkart,
and Swiggy to make product and marketing decision
SQL Skills Demonstrated
Window Functions MIN() OVER (PARTITION BY) to attach cohort month to all rows
CTEs Two chained CTEs to organize cohort data and counts cleanly
Self Join Joining cohort table to itself to get month-0 size for % calculation
Date Functions DATE_TRUNC, AGE, EXTRACT for date grouping and difference
Aggregation COUNT(DISTINCT CustomerID) and GROUP BY for cohort sizing
Business Logic Retention % = (users at month N / users at month 0) × 100
