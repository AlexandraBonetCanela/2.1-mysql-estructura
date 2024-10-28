# OPTICS README

## Assumptions made for OPTICS design

1) We consider the scenario where a customer may find themselves buying the same exact pair of glasses again (i.e their glasses have 
accidentally been broken but customer loved them so much that buys them again).
2) May have have customers leaving outside Spain in countries where postcodes include letters (i.e United kingdom postcode example: N19 5QZ)
3) Customer's telephone numbers may include country's prefix for customers leaving abroad. The "+" would be stored as "00" in the database.
4) All providers are based in Spain
5) Query performance is actively seek. Primary keys are set to int to increase performance.