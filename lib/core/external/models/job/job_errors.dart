abstract class JobErrors implements Exception {}

class JobFetchAllException extends JobErrors {
  String message;
  JobFetchAllException({required this.message});
}

class JobFetchByAuthorException extends JobErrors {
  String message;
  JobFetchByAuthorException({required this.message});
}

class JobFetchByCategoryException extends JobErrors {
  String message;
  JobFetchByCategoryException({required this.message});
}

class JobCreateException extends JobErrors {
  String message;
  JobCreateException({required this.message});
}

class JobDeleteException extends JobErrors {
  String message;
  JobDeleteException({required this.message});
}

class JobUpdateException extends JobErrors {
  String message;
  JobUpdateException({required this.message});
}
