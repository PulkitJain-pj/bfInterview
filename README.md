# Body Metrics API
The API gives average body composition such as weight, bmi and fat measured per week for a particular user.

![mule](https://github.com/PulkitJain-pj/bfInterview/blob/master/images/mule.png)

## System and Experience API
Above picture depicts synopsis of this project.
The system API(bf-s-body-metrics) fetches data from source system which in case is XLSX file.
URL : http://localhost:8081/basicfit/api/shealthkit/v1/body-metrics?userID=1111
Its build as org/api/process(where s stands for system)/version/resource.
The query parameter used here is optional. The reason being to make this API more generic so that it can fetch data for all users or any specific user.

The experience API(bf-e-body-metrics) transforms input data into required format and give user the required response based on source system app or web.
Ideally the transformation should be done in process API but to keep it simple transformations is taken care in experience API.
URL: http://localhost:8087/basicfit/api/ehealthkit/v1/body-metrics/3333  
e in ehealthkit stands for experience. Since it is supposed to fetch data for specific user thats why uri parameter is chosen here.

## Config file
Since its not supposed to deploy in different env, a single config.yaml file was created with all variables defined there.
In ideal scenario different properties file would be build for each environment and runtime variable for env variable will be set in global property.

## global.xml
The global file serves as source for all configurations and error strategies. Its a reusable file which excludes tedious work of setting configurations.
Sometimes its good to create domain project when you share same configurations in multiple projects and want to save some ports.
**Note**:Domain project cannot be deployed in cloud hub.

## Data Weave 
Common function are exported as data weave modules and resused whereever necessary by importing modules. *TotalMeasure.dwl* is one such example.
To calculate avgerage, data is grouped by week and year. Missing data is represented as 0. All numbers are precised to single decimal digit.
Week is calculated as week of the year.

## RAML
Common headers and responses are published to exchange and reused by including it. Traits are created for required headers. Raml is structured to reuse its files/fragments  as much as possible and keep root file cluster free.

### Notes:
Below things are done or assumptions are made to keep it simple:
* All parameters and headers are kept
* Security such as client enforcement or rate throttling or basic auth is not implemented.
* Necessary logging is done to debug the error in application and limit logging of production data.
* Muscle mass is not calculated due to missing data.
