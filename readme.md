# **Estimated Gross Margin Calculation**

*Objectives:*

1. Estimated acqusisiton cost allocation on customer / hourly level for short / middle termn, by using allocation keys
2. Monthly cost calculation on costumer level based on hourly data. 
3. Gross margin calculation on costumer level based on income, acqusition cost and fixed cost. 
4. Gross margin simulation for three scenarios
5. Calculate quantity deviation ( gained, lost and existing costumers)
6. Contracted quantites for short and middle term

*Calculation frequency:* Calculation is done on quarterly basis for B2B ( business to business) and B2C ( business to costumers)\
*Data source:* excel / flat files / database.

*Data processing:*
1. Import: upload / get data from data sources
2. Database : in the database the informations are organized on 3 levels:\
          1. level 1 - interface tables / raw data. Bulk load data with minimal validations. Data validation is done with the help of stored procedures and errors are inserted into "vf" ( verification ) table type.\
          2. level 2 - intermediat calculation / aggregate data  are inserted into "calc" table type.\
          3. level 3 - final dates are organized into "md" table type (dimension and fact table used for creating data models in BI )
3. Data processing : data processing is done using T-SQL procedures. During data processing messages are inserted into log table.
