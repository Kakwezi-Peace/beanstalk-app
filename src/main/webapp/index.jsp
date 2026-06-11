<%@ page import="software.amazon.awssdk.regions.Region" %>
<%@ page import="software.amazon.awssdk.services.dynamodb.DynamoDbClient" %>
<%@ page import="software.amazon.awssdk.services.dynamodb.model.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Beanstalk App</title>
</head>
<body>
  <h1>Hello! I am deployed successfully!</h1>
  <p>Version: 3.0</p>
  <p>Powered by AWS Elastic Beanstalk + Java</p>
  <p>Developed by: Kakwezi Peace</p>
  <%
    String message = "Could not connect to DynamoDB";
    try {
      String tableName = System.getenv("DYNAMODB_TABLE");
      DynamoDbClient client = DynamoDbClient.builder()
        .region(Region.EU_NORTH_1)
        .build();
      Map<String, AttributeValue> key = new HashMap<>();
      key.put("id", AttributeValue.builder().s("1").build());
      GetItemRequest request = GetItemRequest.builder()
        .tableName(tableName)
        .key(key)
        .build();
      GetItemResponse response = client.getItem(request);
      if (response.hasItem()) {
        message = response.item().get("message").s();
      }
    } catch (Exception e) {
      message = "Error: " + e.getMessage();
    }
  %>
  <h2>Message from DynamoDB: <%= message %></h2>
</body>
</html>
