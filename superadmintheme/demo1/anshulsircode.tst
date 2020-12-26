Component : kt-two-step-verification

add this line for get language data

-------------------
@Input() selectedLanguage : any; (current line Number : 17)
-------------------

add two line in "sendLoginCode" function  (current line Number : 76)

-------------------------
const countryCode = this.phoneForm.value.phone.countryCode;
firebase.auth().languageCode = this.selectedLanguage.id; //countryCode;
----------------------------



sendLoginCode() {
    console.log('phoneForm:::', this.phoneForm)
    console.log('this is valid value: ', this.phoneForm.value.phone.e164Number)
    // this.moveToSelectedTab('Step2');
    const appVerifier = this.windowRef.recaptchaVerifier;
    const num = this.phoneForm.value.phone.e164Number;

    const countryCode = this.phoneForm.value.phone.countryCode;
    firebase.auth().languageCode = this.selectedLanguage.id; //countryCode;

    firebase.auth().signInWithPhoneNumber(num, appVerifier)
      .then(result => {
        this.windowRef.confirmationResult = result;
        this.sendCodeSuccess = false;
        this.showCodeBox = true;
        setTimeout(() => {
          this.moveToSelectedTab('Code');
        }, 100);
      })
      .catch(error => {
        console.log('sendlogin code error: ', error);
        this.modalService.showInfoModal(error.message);
        this.showCodeBox = true;
        // this.openSnackBar('Failded', error.message);
      });
  }


HTML : signup.component


replace both 2 line (current line Number : 202)

------------------------------
<kt-two-step-verification *ngIf="askPhoneVerifyToPatient" [selectedLanguage]='selectedLanguage' (verified)="signupPatient($event)">
</kt-two-step-verification>

<kt-two-step-verification *ngIf="askPhoneVerifyToDoctor" [selectedLanguage]='selectedLanguage' (verified)="signupDoctor($event)">
</kt-two-step-verification>
------------------------