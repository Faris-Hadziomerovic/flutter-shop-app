import 'package:flutter/material.dart';

import '../../constants/text_constants.dart';
import '../../constants/validation_messages.dart';
import '../../enums/auth_mode.dart';
import '../../helpers/input_helper.dart';
import '../../helpers/validator.dart';
import '../../models/auth_data.dart';
import '../shared/divider_with_text.dart';

class AuthFormCard extends StatefulWidget {
  const AuthFormCard({super.key});

  @override
  State<AuthFormCard> createState() => _AuthFormCardState();
}

class _AuthFormCardState extends State<AuthFormCard> {
  final _form = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  final _authData = AuthData();

  AuthMode _authMode = AuthMode.login;
  bool _isLoading = false;

  bool get _isLoginMode => _authMode == AuthMode.login;
  bool get _isSignupMode => _authMode == AuthMode.signup;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _changeAuthMode() {
    _form.currentState?.reset();

    setState(() {
      _authMode = _isLoginMode ? AuthMode.signup : AuthMode.login;
    });
  }

  void _submit() async {
    final formIsValid = _form.currentState?.validate() ?? false;

    if (formIsValid) {
      setState(() => _isLoading = true);

      _form.currentState?.save();

      if (_isLoginMode) {
        await _login();
      } else {
        await _signup();
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _login() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    print('Logging in...');
  }

  Future<void> _signup() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    print('Signing up...');
  }

  String? _validateConfirmPassword(String? password) {
    final isPasswordValid = Validator.validatePassword(_passwordController.text) == null;

    if (!isPasswordValid) return null;

    if (password?.isEmpty ?? true) {
      return ValidationMessages.passwordConfirmationMissing;
    }

    if (password != _passwordController.text) {
      return ValidationMessages.passwordsDoNotMatch;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    const divider = SizedBox(height: 15);

    return Card(
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            constraints: BoxConstraints.loose(const Size.fromWidth(700)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  // height: 150,
                  // width: double.infinity,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          _isLoginMode
                              ? TextConstants.loginScreenTitle1
                              : TextConstants.signupScreenTitle1,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 25,
                              ),
                        ),
                      ),
                      divider,
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _isLoginMode
                              ? TextConstants.loginScreenDescription1
                              : TextConstants.signupScreenDescription1,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontSize: 20,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                divider,
                if (_isSignupMode)
                  Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputHelper.createInputDecoration(
                          context,
                          labelText: TextConstants.username,
                          errorMaxLines: 3,
                        ),
                        onSaved: (username) => _authData.username = username,
                        validator: Validator.validateUsername,
                      ),
                      divider,
                    ],
                  ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputHelper.createInputDecoration(
                    context,
                    labelText: TextConstants.email,
                  ),
                  onSaved: (email) => _authData.email = email,
                  validator: Validator.validateEmail,
                ),
                divider,
                TextFormField(
                  controller: _passwordController,
                  textInputAction: _isLoginMode ? TextInputAction.done : TextInputAction.next,
                  decoration: InputHelper.createInputDecoration(
                    context,
                    labelText: TextConstants.password,
                  ),
                  onSaved: (password) => _authData.password = password,
                  validator: Validator.validatePassword,
                ),
                _isSignupMode
                    ? Column(
                        children: [
                          divider,
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            decoration: InputHelper.createInputDecoration(
                              context,
                              labelText: TextConstants.confirmPassword,
                            ),
                            validator: _isSignupMode ? _validateConfirmPassword : null,
                          ),
                        ],
                      )
                    : Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            TextConstants.forgottenPassword,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                divider,
                Container(
                  constraints: BoxConstraints.loose(const Size.fromWidth(500)),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submit,
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  _isLoginMode
                                      ? TextConstants.loginUpper
                                      : TextConstants.signupUpper,
                                ),
                        ),
                      ),
                      DividerWithText(
                        text: _isLoginMode
                            ? TextConstants.dontHaveAccountQuestion
                            : TextConstants.haveAccountQuestion,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: _changeAuthMode,
                          child: Text(
                            _isLoginMode ? TextConstants.signupUpper : TextConstants.loginUpper,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
