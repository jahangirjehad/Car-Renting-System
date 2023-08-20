class SearchAuth {
  var email;
  var gmail;
  emailGet(e) {
    this.email = e;
    print(email);
    am();
  }

  am() {
    gmail = email;
    print("gmail$gmail");
  }
}
