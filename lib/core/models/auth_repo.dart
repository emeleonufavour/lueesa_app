abstract class AuthRepo {
  Future signInWithEmailAndPassword(
      {required String email, required String password});
}
