<!--
title: 'datapipeline-cdc'
description: 'Data Pipeline for Engineering Department built using serverless on top of python runtime'
layout: Doc
framework: v3
platform: AWS
language: python
priority: 2
authorLink: 'https://github.com/serverless'
authorName: 'Yauri Attamimi'
authorAvatar: 'https://avatars.githubusercontent.com/u/515690?s=400&u=c238ad162c1f444e80ebbefc243cfaf701f3420e&v=4'
-->


# Data Pipeline CDC 

This Data Pipeline project was initiated due to a needful from our Engineering department to bring some data from the Data department into our engineering API datasources. 

## Usage

### Deployment

In order to deploy the example, you need to run the following command:

#### Dev Environment

```
$ serverless deploy --stage dev --aws-profile <your AWS profile as configured within your machine>
```

After running deploy, you should see output similar to:

```bash
Deploying datapipeline-cdc to stage dev (eu-west-1)

✔ Service deployed to stack datapipeline-cdc-dev (112s)

functions:
  on_append_driver_daily_metrics: handler.on_append_driver_daily_metrics (1.5 kB)
```

### Bundling dependencies

In case you would like to include third-party dependencies, you will need to use a plugin called `serverless-python-requirements`. You can set it up by running the following command:

```bash
serverless plugin install -n serverless-python-requirements
```

Running the above will automatically add `serverless-python-requirements` to `plugins` section in your `serverless.yml` file and add it as a `devDependency` to `package.json` file. The `package.json` file will be automatically created if it doesn't exist beforehand. Now you will be able to add your dependencies to `requirements.txt` file (`Pipfile` and `pyproject.toml` is also supported but requires additional configuration) and they will be automatically injected to Lambda package during build process. For more details about the plugin's configuration, please refer to [official documentation](https://github.com/UnitedIncome/serverless-python-requirements).
