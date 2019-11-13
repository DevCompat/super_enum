import 'package:sealed/sealed.dart';
import 'package:source_gen_test/source_gen_test.dart';

@ShouldGenerate(r'''
@immutable
abstract class Result<T> {
  const Result(this._type);

  factory Result.success({@required T data, @required String message}) =
      Success<T>;

  factory Result.error({@required Exception exception}) = Error<T>;

  final _Result _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Success) onSuccess,
      @required R Function(Error) onError}) {
    switch (this._type) {
      case _Result.Success:
        return onSuccess(this as Success);
      case _Result.Error:
        return onError(this as Error);
    }
  }
}

@immutable
class Success<T> extends Result<T> {
  const Success({@required this.data, @required this.message})
      : super(_Result.Success);

  final T data;

  final String message;
}

@immutable
class Error<T> extends Result<T> {
  const Error({@required this.exception}) : super(_Result.Error);

  final Exception exception;
}
''')
@sealed
enum _Result {
  @generic
  @Data(fields: [
    DataField('data', Generic),
    DataField('message', String),
  ])
  Success,

  @Data(fields: [DataField('exception', Exception)])
  Error,
}
