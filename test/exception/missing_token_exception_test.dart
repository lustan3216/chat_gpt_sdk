import 'package:chat_gpt_sdk_lululala/src/client/exception/missing_token_exception.dart';
import 'package:chat_gpt_sdk_lululala/src/openai.dart';
import 'package:test/test.dart';

void main() {
  test('empty token', () {
    expect(
      () => OpenAI.createOpenAI(token: ''),
      throwsA(isA<MissingTokenException>()),
    );
  });

  test('token is null', () {
    expect(
      () => OpenAI.createOpenAI(),
      throwsA(isA<MissingTokenException>()),
    );
  });

  group('missing token test', () {
    test("missing token Exception set value test", () {
      final missingToken = MissingTokenException();

      expect(
        missingToken.toString(),
        "Not Missing Your Token look more https://beta.openai.com/account/api-keys",
      );
    });

    test("missing token Exception test", () {
      final missingToken = MissingTokenException();

      expect(missingToken.toString(), isA<String>());
    });
  });
}
