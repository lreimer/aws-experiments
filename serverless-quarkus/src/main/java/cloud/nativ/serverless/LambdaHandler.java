package cloud.nativ.serverless;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Named;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

@Named("default")
public class LambdaHandler implements RequestHandler<Object, Map<String, Object>> {

    @Override
    public Map<String, Object> handleRequest(Object input, Context context) {
        context.getLogger().log("Invocation of Quarkus AWS Lambda.\n");
        return payload();
    }

    Map<String, Object> payload() {
        Map<String, Object> payload = new HashMap<>();
        payload.put("message", "Hello Serverless Quarkus.");
        payload.put("currentTimeMillis", System.currentTimeMillis());
        return payload;
    }
}
