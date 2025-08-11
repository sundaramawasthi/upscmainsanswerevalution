exports.handler = async (event) => {
  const data = JSON.parse(event.body);
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Answer submitted!", data }),
  };
};
