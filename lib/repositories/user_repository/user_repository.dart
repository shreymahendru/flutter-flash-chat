abstract class UserRepository {
  Future<void> signInWithCredentials(String email, String password);
  Future<void> signOut();
  Future<bool> isSignedIn();

  Future<String> getUser();
  Future<void> signUp({String email, String password});
}
