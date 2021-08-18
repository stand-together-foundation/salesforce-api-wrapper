# Wrap the Salesforce API 

This R project provides a few functions for making use of the `salesforcer` package to extract information about STF organizations (aka `catalysts`, aka Salesforce `Accounts`), `evaluations`, `referrals`, and `opportunities`. 

## Prerequisite

- Install `R` on your local machine as described [here](https://rstudio-education.github.io/hopr/starting.html). While not technically required, you should also install RStudio as described at the same location. 

- Install `git` on your local machine as described [here](https://github.com/git-guides/install-git).

- Get an STF GitHub account from Joe or Tyler.

- Setup your GitHub account on your local machine as described [here](https://docs.github.com/en/get-started/quickstart/set-up-git). 

- Get a Salesforce security token as described [here](https://help.salesforce.com/s/articleView?id=sf.user_security_token.htm&type=5)

- Clone this repo. If you are using RStudio, that is most easily accomplished by following the instructions [here](https://happygitwithr.com/rstudio-git-github.html#clone-the-new-github-repository-to-your-computer-via-rstudio). 

- Create a `.env` file in the project directory using the following template: 

```
SF_USER=me@standtogether.org
SF_PASSWORD=myPasswordToSalesForce
SF_TOKEN=myCaSesenSItivETokeN
```

## Source `load-concept-tables`

For now, there is only one script in this project. It is called `load-concept-tables.R`. 

Once you have completed the steps above, you should be able to source this script from the R console (e.g. in RStudio). 

```
source('~/salesforce-api-wrapper/load-concept-tables.R')
```

If all goes well, this script should assign 5 `tibbles` to your project environment to be used in subsequent analysis. 

