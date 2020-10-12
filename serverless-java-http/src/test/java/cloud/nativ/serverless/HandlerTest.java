package cloud.nativ.serverless;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.when;

import com.amazonaws.services.lambda.runtime.ClientContext;
import com.amazonaws.services.lambda.runtime.CognitoIdentity;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class HandlerTest {

    Context context;

    @Mock
    LambdaLogger logger;

    @BeforeEach
    void init() {
        context = new TestableContext();
    }

    @Test
    void testHandleRequest() {
        APIGatewayV2HTTPEvent input = APIGatewayV2HTTPEvent.builder().withBody("Hello World.")
                .withIsBase64Encoded(false).build();

        Handler handler = new Handler();
        APIGatewayV2HTTPResponse response = handler.handleRequest(input, context);

        assertNotNull(response, "Handler response is NULL.");
        assertEquals(200, response.getStatusCode(), "Status code is wrong.");
    }

    public class TestableContext implements Context {

        @Override
        public String getAwsRequestId() {
            return null;
        }

        @Override
        public String getLogGroupName() {
            return null;
        }

        @Override
        public String getLogStreamName() {
            return null;
        }

        @Override
        public String getFunctionName() {
            return "serverlessHttpJava";
        }

        @Override
        public String getFunctionVersion() {
            return "1.0.0";
        }

        @Override
        public String getInvokedFunctionArn() {
            return null;
        }

        @Override
        public CognitoIdentity getIdentity() {
            return null;
        }

        @Override
        public ClientContext getClientContext() {
            return null;
        }

        @Override
        public int getRemainingTimeInMillis() {
            return 0;
        }

        @Override
        public int getMemoryLimitInMB() {
            return 0;
        }

        @Override
        public LambdaLogger getLogger() {
            return logger;
        }

    }
}
