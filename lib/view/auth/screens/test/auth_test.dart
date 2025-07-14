import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
// import 'your_provider_auth.dart'; // Replace with your actual import

class AuthTestingPage extends StatefulWidget {
  const AuthTestingPage({Key? key}) : super(key: key);

  @override
  State<AuthTestingPage> createState() => _AuthTestingPageState();
}

class _AuthTestingPageState extends State<AuthTestingPage> {
  // Controllers for Login
  final _loginUsernameController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  // Controllers for Register
  final _registerFullNameController = TextEditingController();
  final _registerUsernameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmPasswordController = TextEditingController();
  final _registerPhoneController = TextEditingController();
  final _registerDateOfBirthController = TextEditingController();
  final _registerGenderController = TextEditingController();
  final _registerBioController = TextEditingController();
  final _registerLinkController = TextEditingController();

  // Controllers for OTP Verification
  final _verifyEmailController = TextEditingController();
  final _verifyOtpController = TextEditingController();

  // Controllers for Registration OTP
  final _verifyRegisterEmailController = TextEditingController();
  final _verifyRegisterOtpController = TextEditingController();

  // Controllers for Change Password
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  // Controllers for Send OTP
  final _sendOtpEmailController = TextEditingController();

  @override
  void dispose() {
    // Dispose all controllers
    _loginUsernameController.dispose();
    _loginPasswordController.dispose();
    _registerFullNameController.dispose();
    _registerUsernameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    _registerPhoneController.dispose();
    _registerDateOfBirthController.dispose();
    _registerGenderController.dispose();
    _registerBioController.dispose();
    _registerLinkController.dispose();
    _verifyEmailController.dispose();
    _verifyOtpController.dispose();
    _verifyRegisterEmailController.dispose();
    _verifyRegisterOtpController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _sendOtpEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Testing'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ProviderAuth>(
        builder: (context, authProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Section
                _buildStatusSection(authProvider),
                const SizedBox(height: 20),

                // Login Section
                _buildLoginSection(authProvider),
                const SizedBox(height: 20),

                // Register Section
                _buildRegisterSection(authProvider),
                const SizedBox(height: 20),

                // Verify Registration OTP Section
                _buildVerifyRegisterSection(authProvider),
                const SizedBox(height: 20),

                // Send Verification OTP Section
                _buildSendOtpSection(authProvider),
                const SizedBox(height: 20),

                // Verify Email OTP Section
                _buildVerifyEmailOtpSection(authProvider),
                const SizedBox(height: 20),

                // Change Password Section
                _buildChangePasswordSection(authProvider),
                const SizedBox(height: 20),

                // Utility Buttons Section
                _buildUtilitySection(authProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusSection(ProviderAuth authProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  authProvider.isLoading ? Icons.hourglass_empty : Icons.check_circle,
                  color: authProvider.isLoading ? Colors.orange : Colors.green,
                ),
                const SizedBox(width: 8),
                Text('Loading: ${authProvider.isLoading}'),
              ],
            ),
            const SizedBox(height: 8),
            if (authProvider.errorMessage != null)
              Row(
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Error: ${authProvider.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  authProvider.currentUserData != null ? Icons.person : Icons.person_outline,
                  color: authProvider.currentUserData != null ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text('User: ${authProvider.currentUserData?.toString() ?? 'Not logged in'}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginSection(ProviderAuth authProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _loginUsernameController,
              decoration: const InputDecoration(
                labelText: 'Username or Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _loginPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: authProvider.isLoading ? null : () async {
                await authProvider.login(
                  usernameOrEmail: _loginUsernameController.text,
                  password: _loginPasswordController.text,
                  context: context,
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterSection(ProviderAuth authProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Register',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _registerFullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _registerUsernameController,
              decoration: const InputDecoration(
                labelText: 'Username *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _registerEmailController,
              decoration: const InputDecoration(
                labelText: 'Email *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _registerPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _registerConfirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _registerPhoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _registerDateOfBirthController,
              decoration: const InputDecoration(
                labelText: 'Date of Birth (YYYY-MM-DD) *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _registerGenderController,
              decoration: const InputDecoration(
                labelText: 'Gender *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _registerBioController,
              decoration: const InputDecoration(
                labelText: 'Bio (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _registerLinkController,
              decoration: const InputDecoration(
                labelText: 'Link (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: authProvider.isLoading ? null : () async {
                await authProvider.register(
                  fullName: _registerFullNameController.text,
                  username: _registerUsernameController.text,
                  email: _registerEmailController.text,
                  password: _registerPasswordController.text,
                  confirmPassword: _registerConfirmPasswordController.text,
                  phoneNumber: _registerPhoneController.text,
                  dateOfBirth: _registerDateOfBirthController.text,
                  gender: _registerGenderController.text,
                  context: context,
                  bio: _registerBioController.text.isEmpty ? null : _registerBioController.text,
                  link: _registerLinkController.text.isEmpty ? null : _registerLinkController.text,
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyRegisterSection(ProviderAuth authProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verify Registration OTP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _verifyRegisterEmailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _verifyRegisterOtpController,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: authProvider.isLoading ? null : () async {
                await authProvider.verifyRegister(
                  email: _verifyRegisterEmailController.text,
                  otp: _verifyRegisterOtpController.text,
                  context: context,
                );
              },
              child: const Text('Verify Registration'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendOtpSection(ProviderAuth authProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send Verification OTP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _sendOtpEmailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: authProvider.isLoading ? null : () async {
                await authProvider.sendVerificationOtp(
                  email: _sendOtpEmailController.text,
                  context: context,
                );
              },
              child: const Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyEmailOtpSection(ProviderAuth authProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verify Email OTP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _verifyEmailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _verifyOtpController,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: authProvider.isLoading ? null : () async {
                await authProvider.verifyEmailOtp(
                  email: _verifyEmailController.text,
                  otp: _verifyOtpController.text,
                  context: context,
                );
              },
              child: const Text('Verify Email OTP'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangePasswordSection(ProviderAuth authProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: authProvider.isLoading ? null : () async {
                await authProvider.changePassword(
                  currentPassword: _currentPasswordController.text,
                  newPassword: _newPasswordController.text,
                  context: context,
                );
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUtilitySection(ProviderAuth authProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Utility Functions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: authProvider.isLoading ? null : () async {
                    await authProvider.logout(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Logout'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    bool isAuth = await authProvider.isAuthenticated();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Is Authenticated: $isAuth'),
                      ),
                    );
                  },
                  child: const Text('Check Auth'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    authProvider.clearError();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Clear Error'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    authProvider.clearAll();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Clear All'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}