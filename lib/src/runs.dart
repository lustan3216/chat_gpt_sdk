import 'package:chat_gpt_sdk_lululala/chat_gpt_sdk_lululala.dart';
import 'package:chat_gpt_sdk_lululala/src/client/client.dart';
import 'package:chat_gpt_sdk_lululala/src/model/chat_complete/response/chat_choice_sse.dart';
import 'package:chat_gpt_sdk_lululala/src/model/run/request/create_run.dart';
import 'package:chat_gpt_sdk_lululala/src/model/run/request/create_thread_and_run.dart';
import 'package:chat_gpt_sdk_lululala/src/model/run/response/create_run_response.dart';
import 'package:chat_gpt_sdk_lululala/src/model/run/response/create_thread_and_run_data.dart';
import 'package:chat_gpt_sdk_lululala/src/model/run/response/list_run.dart';
import 'package:chat_gpt_sdk_lululala/src/utils/constants.dart';

class Runs {
  final OpenAIClient _client;
  final Map<String, String> _headers;

  Runs({required OpenAIClient client, required Map<String, String> headers})
      : _client = client,
        _headers = headers;

  ///Create a run.
  ///[createRun]
  Future<CreateRunResponse> createRun({
    required String threadId,
    required CreateRun request,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$threadId/$kRuns",
      request.toJson(),
      headers: _headers,
      onSuccess: CreateRunResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  @Deprecated("using version 2")

  ///Create a thread and run it in one request.
  ///[createThreadAndRun]
  Future<CreateThreadAndRunData> createThreadAndRun({
    required CreateThreadAndRun request,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$kRuns",
      request.toJson(),
      headers: _headers,
      onSuccess: CreateThreadAndRunData.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  ///Create a thread and run it in one request.
  ///[createThreadAndRunV2]
  Future<CreateRunResponse> createThreadAndRunV2({
    required CreateThreadAndRun request,
  }) {
    return _client.post(
      _client.apiUrl + kThread + "/$kRuns",
      request.toJson(),
      headers: _headers,
      onSuccess: CreateRunResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  Stream<dynamic> createThreadAndRunV2SSE({
    required CreateThreadAndRun request,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.sse(
      _client.apiUrl + kThread + "/$kRuns",
      request.toJson()..addAll({"stream": true}),
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      complete: (it) {
        return it;
      },
      headers: {
        ..._headers,
        'OpenAI-Beta': 'assistants=v2',
      },
    );
  }

  Stream<dynamic> createRunV2SSE({
    required String threadId,
    required CreateRun request,
    void Function(CancelData cancelData)? onCancel,
  }) {
    return _client.sse(
      _client.apiUrl + kThread + "/$threadId/$kRuns",
      request.toJson()..addAll({"stream": true}),
      onCancel: (it) => onCancel != null ? onCancel(it) : null,
      complete: (it) {
        return it;
      },
      headers: {
        ..._headers,
        'OpenAI-Beta': 'assistants=v2',
      },
    );
  }

  Future<ListRun> listRuns({
    required String threadId,
    int limit = 20,
    String order = 'desc',
    String? after,
    String? before,
  }) {
    String url = _client.apiUrl + kThread + "/$threadId/$kRuns?limit=$limit&order=$order";

    if (before != null && before.isNotEmpty) {
      url += '&before=$before';
    }
    if (after != null && after.isNotEmpty) {
      url += '&after=$after';
    }

    return _client.get(
      url,
      headers: _headers,
      onSuccess: ListRun.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  Future<ListRun> listRunSteps({
    required String threadId,
    required String runId,
    int limit = 20,
    String order = 'desc',
    String? after,
    String? before,
  }) {
    String url = _client.apiUrl + kThread + "/$threadId/$kRuns/$runId/steps?limit=$limit&order=$order";

    if (before != null && before.isNotEmpty) {
      url += '&before=$before';
    }
    if (after != null && after.isNotEmpty) {
      url += '&after=$after';
    }

    return _client.get(
      url,
      headers: _headers,
      onSuccess: ListRun.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  Future<CreateRunResponse> retrieveRun({
    required String threadId,
    required String runId,
  }) {
    return _client.get(
      _client.apiUrl + kThread + "/$threadId/$kRuns/$runId",
      headers: _headers,
      onSuccess: CreateRunResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  Future<CreateRunResponse> retrieveRunStep({
    required String threadId,
    required String runId,
    required String stepId,
  }) {
    return _client.get(
      _client.apiUrl + kThread + "/$threadId/$kRuns/$runId/steps/$stepId",
      headers: _headers,
      onSuccess: CreateRunResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  ///
  /// [metadata]
  /// Set of 16 key-value pairs that can be attached to an object.
  /// This can be useful for storing additional information about
  /// the object in a structured format. Keys can be a maximum of 64
  /// characters long and values can be a maxium of 512 characters long.
  Future<CreateRunResponse> modifyRun({
    required String threadId,
    required String runId,
    required Map<String, dynamic> metadata,
  }) {
    return _client.post(
      _client.apiUrl + "$kThread/$threadId/$kRuns/$runId",
      metadata,
      headers: _headers,
      onSuccess: CreateRunResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  ///
  /// When a run has the status: "requires_action"
  /// and required_action.type is submit_tool_outputs,
  /// this endpoint can be used to submit the outputs from
  /// the tool calls once they're all completed.
  /// All outputs must be submitted in a single request.
  /// [submitToolOutputsToRun]
  Future<CreateRunResponse> submitToolOutputsToRun({
    required String threadId,
    required String runId,
    required List<Map<String, dynamic>> toolOutputs,
  }) {
    return _client.post(
      _client.apiUrl + "$kThread/$threadId/$kRuns/$runId/submit_tool_outputs",
      {
        'tool_outputs': toolOutputs,
      },
      headers: _headers,
      onSuccess: CreateRunResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }

  ///
  /// Cancels a run that is in_progress.
  /// [cancelRun]
  Future<CreateRunResponse> cancelRun({
    required String threadId,
    required String runId,
  }) {
    return _client.post(
      _client.apiUrl + "$kThread/$threadId/$kRuns/$runId/cancel",
      {},
      headers: _headers,
      onSuccess: CreateRunResponse.fromJson,
      onCancel: (cancelData) => null,
    );
  }
}
