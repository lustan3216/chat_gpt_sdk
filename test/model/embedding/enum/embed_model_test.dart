import 'package:chat_gpt_sdk_lululala/chat_gpt_sdk_lululala.dart';
import 'package:chat_gpt_sdk_lululala/src/model/embedding/enum/embed_model.dart';
import 'package:test/test.dart';

void main() {
  group('openai embedding model test', () {
    test('openai embedding model test textEmbeddingAda002', () {
      final textEmbeddingAda002 = TextEmbeddingAda002EmbedModel();

      expect(textEmbeddingAda002.model, kEmbeddingAda002);
    });

    test('openai embedding model test null value', () {
      EmbedModel? textSearchAdaDoc001;

      expect(textSearchAdaDoc001, null);
    });

    test('openai embedding model test from value', () {
      final custom = EmbedModelFromValue(model: 'model');

      expect(custom.model, 'model');
    });
  });
}
