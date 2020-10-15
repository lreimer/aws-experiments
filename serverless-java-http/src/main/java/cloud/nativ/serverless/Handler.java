package cloud.nativ.serverless;

import java.util.HashMap;
import java.util.Map;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class Handler implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

    private static final Gson GSON = new GsonBuilder().setPrettyPrinting().create();

	@Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent input, Context context) {
        // initial invocation logging
        var logger = context.getLogger();
        logger.log(GSON.toJson(invocation(input, context)));

        // construct the headers and payload
        var headers = headers();
        var payload = payload(input);

        return APIGatewayV2HTTPResponse.builder()
                    .withStatusCode(200)
                    .withIsBase64Encoded(false)
                    .withHeaders(headers)
                    .withBody(GSON.toJson(payload))
                    .build();
    }

    Map<String, Object> invocation(APIGatewayV2HTTPEvent input, Context context) {
        Map<String, Object> invocation = new HashMap<>();
        invocation.put("context", context);
        invocation.put("event", input);
        invocation.put("environment", System.getenv());
        return invocation;
    }

    Map<String, String> headers() {
        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        return headers;
    }

    Map<String, Object> payload(APIGatewayV2HTTPEvent input) {
        Map<String, Object> payload = new HashMap<>();
        payload.put("message", "Hello Serverless Java HTTP.");
        payload.put("input", input);
        payload.put("currentTimeMillis", System.currentTimeMillis());
        return payload;
    }
    
}
