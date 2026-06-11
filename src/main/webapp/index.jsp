<%@ page import="software.amazon.awssdk.regions.Region" %>
<%@ page import="software.amazon.awssdk.services.dynamodb.DynamoDbClient" %>
<%@ page import="software.amazon.awssdk.services.dynamodb.model.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head><title>My Beanstalk App</title></head>
<body>
  <h1>Hello! I am deployed successfully!</h1>
  <p>Version: 3.0</p>
  <p>Powered by AWS Elastic Beanstalk + Java</p>
  <p>Developed by: Kakwezi Peace</p>
  <%
    String dbMessage = "Could not connect to DynamoDB";
    try {
      String tableName = System.getenv("DYNAMODB_TABLE");
      DynamoDbClient dbClient = DynamoDbClient.builder()
        .region(Region.EU_NORTH_1)
        .build();
      Map<String, AttributeValue> itemKey = new HashMap<>();
      itemKey.put("id", AttributeValue.builder().s("1").build());
      GetItemRequest getRequest = GetItemRequest.builder()
        .tableName(tableName)
        .key(itemKey)
        .build();
      GetItemResponse getResponse = dbClient.getItem(getRequest);
      if (getResponse.hasItem()) {
        dbMessage = getResponse.item().get("message").s();
      } else {
        dbMessage = "Item not found in table";
      }
    } catch (Throwable e) {
      dbMessage = "Error: " + e.getMessage();
    }
  %>
  <h2>Message from DynamoDB: <%= dbMessage %></h2>
</body>
</html>
