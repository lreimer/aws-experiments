import { Handler } from 'aws-lambda';

export const index: Handler = (event: any) => {
  const response = {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: 'Hello Serverless Typescript.',
        input: event,
      },
      null,
      2
    ),
  };

  return new Promise((resolve) => {
    resolve(response)
  })
}