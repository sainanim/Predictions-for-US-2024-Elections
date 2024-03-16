To obtain the raw data used for analysis, follow these steps and save the obtained data files in this folder (`data/raw_data`)

1. For the survey data:
- Go to https://ropercenter.cornell.edu/ipoll/study/31120637 and register/login
- Download CSV file from the Datasets group in the Downloads tab.
  
The downloaded csv is the survey raw dataset we used. 

2. For the poststratification data:
- Create an account with IPUMS and then use this to access the American Community Surveys (ACS).
- Choose the 2022 ACS and select the variables : EDUC, FTOTINC, SEX, STATEICP, AGE
- Download the dataset as a csv
- Convert the csv to a parquet file and name it usa.parquet
  
The parquet file is the poststratification raw dataset we used.
