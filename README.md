# PFX Certificate Bundle Generator

A HTML5 tool for generating and validating PFX/PKCS#12 certificate bundles with automatic chain validation and AIA fetching, designed for Azure WAF deployment.

## Features

### Certificate Bundle Creation
- **Automatic Chain Validation**: Verifies certificate chain completeness
- **Smart Certificate Ordering**: Automatically sorts certificates (leaf → intermediate → root)
- **AIA Fetching**: Provides direct links to download missing intermediate CA certificates
- **CA Provider Detection**: Identifies certificate authorities and provides download links
- **Add More Certificates**: Append additional certificates with automatic duplicate detection
- **Multiple Input Formats**: Supports .crt, .cer, .pem, .key files and text paste
- **DER Format Support**: Automatically converts DER-encoded certificates to PEM
- **Encrypted Key Support**: Handles password-protected private keys

### Certificate Bundle Validation
- **PFX Inspector**: Upload and examine existing PFX bundles
- **Contents Display**: View all certificates and their properties
- **Chain Validation**: Verify certificate chain completeness in PFX files
- **Friendly Name Display**: Shows certificate friendly names from PFX bundles

### Security & Deployment
- **Azure WAF Ready**: Generates PFX files compatible with Azure Application Gateway/WAF
- **Memory-Only Storage**: All data stored in memory, cleared after download
- **Client-Side Processing**: 100% browser-based, no server uploads
- **Offline Capable**: Can run in isolated environments with local dependencies
- **Two-Column Layout**: Separate interfaces for creating and checking PFX bundles

## Quick Setup

### Option 1: Automated Setup (Recommended for Windows)

Run the included PowerShell script to automatically download dependencies:

```powershell
.\setup.ps1
```

This script will:
- Download the latest stable version of node-forge (forge.min.js)
- Save it to the current directory
- Verify the download
- Prepare the tool for offline use

### Option 2: Manual Download from CDN (Internet Required)

Download the latest stable version of node-forge:

```powershell
# Using PowerShell
Invoke-WebRequest -Uri "https://cdn.jsdelivr.net/npm/node-forge@1.3.1/dist/forge.min.js" -OutFile "forge.min.js"
```

Or using curl:

```bash
curl -o forge.min.js https://cdn.jsdelivr.net/npm/node-forge@1.3.1/dist/forge.min.js
```

### Option 3: Download from npm (Internet Required)

```bash
# Install node-forge via npm
npm install node-forge

# Copy the minified file to the pki directory
cp node_modules/node-forge/dist/forge.min.js .
```

### Option 4: Manual Download from GitHub

1. Visit https://github.com/digitalbazaar/forge/releases
2. Download the latest release
3. Extract `forge.min.js` from the `dist` folder
4. Place it in the same directory as `index.html`

### Verification

After downloading, verify the file is in place:

```powershell
# PowerShell
Test-Path forge.min.js
```

The tool will automatically:
1. Try to load forge.js from CDN (fastest)
2. If CDN fails, fall back to local `forge.min.js`
3. Display an error if neither source is available

## Usage

### Creating PFX Bundles (Left Column)

1. Open `index.html` in a modern web browser (Chrome, Firefox, Edge)
2. **Step 1**: Load your certificate(s) - upload file or paste PEM text
   - Tool automatically sorts certificates in correct order
   - Use "Add More Certificates" button to append additional certificates
   - Automatic duplicate detection prevents re-adding same certificates
3. **Step 2**: Load your private key - upload file or paste PEM text (with password if encrypted)
4. **Step 3**: Validate the certificate chain
   - Tool identifies missing intermediate/root certificates
   - Provides direct download links via AIA extensions
   - Shows CA provider links when AIA is unavailable
5. **Step 4**: Generate PFX with a strong password and download

### Checking PFX Bundles (Right Column)

1. Upload an existing PFX/PKCS#12 file
2. Enter the PFX password
3. Click "Check PFX Bundle" to view:
   - All certificates in the bundle
   - Certificate details (subject, issuer, validity dates, thumbprints)
   - Friendly names assigned to certificates
   - Chain validation status
   - Missing intermediate certificates (if any)

## Supported Formats

### Certificates
- PEM-encoded (.crt, .cer, .pem)
- Base64-encoded certificates
- DER-encoded binary files (.cer, .crt) - automatically converted to PEM
- Multiple certificates in single file (chain)

### Private Keys
- RSA Private Key (`-----BEGIN RSA PRIVATE KEY-----`)
- PKCS#8 Private Key (`-----BEGIN PRIVATE KEY-----`)
- EC Private Key (`-----BEGIN EC PRIVATE KEY-----`)
- Encrypted Private Key (`-----BEGIN ENCRYPTED PRIVATE KEY-----`)

### PFX/PKCS#12 Files
- Standard PFX files (.pfx, .p12)
- Password-protected bundles
- Bundles with multiple certificates

## Security Features

- **Client-side only**: No data is sent to any server
- **Memory-only storage**: Sensitive data cleared on page unload
- **HTTPS recommended**: Works on localhost or HTTPS for production
- **Auto-cleanup**: Prompts to clear data after PFX download
- **CSP headers**: Content Security Policy for XSS protection

## Azure WAF Deployment

The generated PFX file can be directly uploaded to:
- Azure Application Gateway
- Azure Web Application Firewall (WAF)
- Azure Front Door
- Any service requiring PKCS#12 certificate bundles

## Troubleshooting
Run `.\setup.ps1` to automatically download the library
2. Check internet connection (for CDN access)
3. Download `forge.min.js` locally (see Setup instructions)
4. Verify the file is in the same directory as `index.html`
5. Check browser console for specific error messages

### Certificate Chain Issues

- Use "Validate Chain" to check completeness
- Tool will display direct download links for missing certificates
- Click on AIA URLs or CA provider links to download missing intermediates/roots
- Use "Add More Certificates" to append downloaded certificates
- Tool automatically prevents duplicate certificates
- Certificates are automatically sorted in correct order (leaf → intermediate → root)

### Private Key Issues

- Ensure key format is supported (RSA, PKCS#8)
- Provide password if key is encrypted
- Verify key matches the certificate (tool will validate automatically)
- DER-encoded keys are not supported - convert to PEM first

### PFX Checking Issues

- Ensure correct password is provided
- PFX file must be valid PKCS#12 format
- Tool will display detailed error messages if decryption fails
### Private Key Issues

- Ensure key format is supported (RSA, PKCS#8)
- PWhat's New

### Version 1.1.0 - December 10, 2025

**New Features:**
- **PFX Bundle Checker**: New right-column interface to inspect existing PFX files
- **Automated Setup Script**: PowerShell script (`setup.ps1`) for easy dependency installation
- **Smart Certificate Addition**: "Add More Certificates" button with automatic duplicate detection
- **Enhanced Certificate Display**: Formatted serial numbers and thumbprints for root certificates
- **CA Provider Detection**: Automatic identification of certificate authorities with download links
- **DER Format Support**: Automatic conversion of binary DER certificates to PEM

**Improvements:**
- Two-column layout separating creation and validation workflows
- Better chain validation with step-by-step instructions
- Enhanced AIA extension parsing and display
- Improved certificate ordering algorithm
- More detailed certificate information display

### Version 1.0.0 - December 7, 2025

Initial release with core features:
- PFX certificate bundle generation
- Automatic chain validation
- AIA fetching support
- Multiple input format support
- Azure WAF compatibility

## License

Created by Aleksandr Sukhov
- Safari 14+
- Opera 76+