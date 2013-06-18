TWStatus
========

Show notification status on Status bar mimicking [Sunrise](http://www.sunrise.am/) and [Mailbox](http://www.mailboxapp.com/).

<p align="center"><img src="https://raw.github.com/petersantino/TWStatus/master/github-images/loading.png"/></p>

Status with ``` UIActivityIndicator ```

<p align="center"><img src="https://raw.github.com/petersantino/TWStatus/master/github-images/status.png"/></p>

Plain status

<p align="center">TODO: add pic...</p>
Status with a checkmark

##Installation
Copy contents of the 'TWStatus' folder to your project

##Usage (Original and new added by @nicoschtein)

```objc
//Show status with activity indicator
+ (void)showLoadingWithStatus:(NSString *)status;

//Show plain status
+ (void)showStatus:(NSString *)status;

//Dismiss current status
+ (void)dismiss;

//Dismiss current status after time interval
+ (void)dismissAfter:(NSTimeInterval)interval;

//////////  Added by @nicoschtein  /////////////
//Show status with a Checkmark (symbol ✔ or ✓) 
+ (void)showStatusWithCheck:(NSString *)status;

// No need to call a diferent method just to dismiss every time, so here you have it all in one handy message:

//Show status with activity indicator and dismiss after interval
+ (void)showLoadingWithStatus:(NSString *)status dismissAfter:(NSTimeInterval)interval;

//Show plain status and dismiss after interval
+ (void)showStatus:(NSString *)status dismissAfter:(NSTimeInterval)interval;

//Show status with a Checkmark (symbol ✔ or ✓) and dismiss after interval
+ (void)showStatusWithCheck:(NSString *)status dismissAfter:(NSTimeInterval)interval;

```



##Requirements
- iOS >= 5.0
- ARC

## License
TWStatus is available under the MIT license.

Copyright (C) 2013 Thanakrit Weekhamchai

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
