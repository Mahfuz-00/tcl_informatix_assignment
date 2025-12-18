// --------------
// Abstract Failure class with concrete implementations.
// Extends for specific errors (e.g., server, network, cache) to enable targeted handling in BLoCs/states.
// Includes message for user-friendly errors.
// This is More of a placeholder for future live backend(If possible)
// --------------
abstract class Failure {
final String message;

Failure(this.message);
}

class ServerFailure extends Failure {
ServerFailure([String message = 'Server error  Failure']) : super(message);
}

class NetworkFailure extends Failure {
NetworkFailure([String message = 'No internet connection']) : super(message);
}

class CacheFailure extends Failure {
CacheFailure([String message = 'Cache error']) : super(message);
}

class ParsingFailure extends Failure {
ParsingFailure([String message = 'Data parsing error']) : super(message);
}