## INTRODUCTION / PROBLEM STATEMENNT
Beejan Technologies, a telecom company has a problem. 
Everyday  they receive thoisands of customers complain about issues relating to poor network, incorrect billing or bad customer service.
As a tele company, it is required that they look into this issue, investigate the leading cause and offer solutions as soon as possible,
else they lose customers to their competitors especially Immaculate telecop.
These requests come in from different source channels and some more frequent than the other like the call centre logfiles ,while others come in batches call centre log files, SMS and websites. 
it is almost inpossible to trace these complaints with data coming in from different angles and consolidationg becomes a bottleneck.
Because reporting team from each department manually pulls this data everyday, There is conflict in kpis and management is confused on which to rely on.

Management is frustrated because it would require weeks for reporting experts to manually compoile consistent spreadsheet inordr to make sense of the customers various complaints.as the need for urgent and immediate action s required based on the informatio given by the customers.

Managementtherefore requires a solution that consolidates these information from customers from the different sources into a ccentral repository system

Because some ata come in more frequent than the others like the call log files, there is need to capture them in ral time or setup a notification channel into the log for quick data capture
as for the social media handle like tweets from x a near realtime  data capture is required
this data needs to be stored in a central repository as they come in without any changes happening yet. this should serve as a source of truth for the engineer who would be building the pipeline. Making sure no necessary information is left out and can always at any point travel back to this stage to enrich the pipeline.
transformation and cleaning wold later be done in another stage where the data is made ready for generating useful insights to anser the business questions.Customer complains can be grouped into complaint issues, billing and payment,customer support and service outage categories.this clean data will be saved in parquet to allow further engineers use its built in schema to further work on the data
to ensure that management gets the report built from this pipeline everyday at 9am and to ensure only clean and trusted data is processed downstream, observation is built at every stage with rules to check and notify the engineer when these rules are broken and to ensure that the pipline runs automatically picking the data from these sources and processing it downsstream to feed the dashboard that management will require to make swift decisions
to ensure this pipeline runs uninterrupted with no failure  it will be hosted on a cloud server with the services and resources of this server issues like resource allocation and data scaling are handled

