---
categories: ['Website Development']
tags: ['PHP', 'PDF']
title: 'How to convert HTML to PDF in PHP'
---
In this tutorial, we will be learning on how to convert HTML to PDF in PHP.

There are many PHP libraries around the internet nowadays but most of them just don’t work like you expected it to be. I have been required by my client to automatically generate documents in pdf format. I have tried many PHP pdf libraries and this library really makes it possible.

## Step 1: Create the HTML file.
This static HTML file will be converted to pdf. You may use all HTML tags that you know combined with CSS.

This is somehow WYSIWYG like process, where the look of the output in your HTML file will also be the look when it was converted to pdf.

In this example, I will just create a simple invoice document. We will name the file as `file.html` and the content as follows.

```html
<html>
<head>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      font-family: Times New Roman;
    }
  </style>
</head>
<body>
  <table cellpadding="10" cellspacing="0" width="100%">
    <tr style="background-color: #333; color: #fff;">
      <td align="center">
        <img src="https://placehold.it/450x150&text=YOUR%20LOGO"><br><br><b>1234 Central Avenue, Ermita, Manila</b>
      </td>
    </tr>
    <tr>
      <td>
        <h1>INVOICE #4321</h1>
        April 14, 2050<br><br>
        <b>Bill To:</b><br>
        John Smith<br>
        Beehive Co.<br>
        Beehive Building, 1226 South Avenue<br>
        Manila, 1000<br>
        +63 (917) 543-2109<br>
        contact@beehive.xyz
      </td>
    </tr>
  </table>
  <br><br>
  <table cellpadding="10" cellspacing="0" width="100%">
    <tr>
      <th width="80%" style="background-color: #333; color: #fff; border: 1px solid #000;">DESCRIPTION</th>
      <th width="20%" style="background-color: #333; color: #fff; border: 1px solid #000;">AMOUNT</th>
    </tr>
    <tr>
      <td width="80%" style="border: 1px solid #000;">Sample Item 1</td>
      <td width="20%" style="border: 1px solid #000;" align="right">100,000.00 PHP</td>
    </tr>
    <tr>
      <td width="80%" style="border: 1px solid #000;">Sample Item 2</td>
      <td width="20%" style="border: 1px solid #000;" align="right">100,000.00 PHP</td>
    </tr>
    <tr>
      <td width="80%" style="border: 1px solid #000;">Sample Item 3</td>
      <td width="20%" style="border: 1px solid #000;" align="right">100,000.00 PHP</td>
    </tr>
    <tr>
      <td width="80%" style="border: 1px solid #000;">Sample Item 4</td>
      <td width="20%" style="border: 1px solid #000;" align="right">100,000.00 PHP</td>
    </tr>
    <tr>
      <td width="80%" style="border: 1px solid #000;">Sample Item 5</td>
      <td width="20%" style="border: 1px solid #000;" align="right">100,000.00 PHP</td>
    </tr>
    <tr>
      <td width="80%" style="border: 1px solid #000;">Sample Item 6</td>
      <td width="20%" style="border: 1px solid #000;" align="right">100,000.00 PHP</td>
    </tr>
    <tr>
      <td style="border: 1px solid #000;" align="right"><b>TOTAL</b></td>
      <td style="background-color: #333; color: #fff; border: 1px solid #000;" align="right">600,000.00 PHP</td>
    </tr>
  </table>
  <br><br>
  If you have any concerns about this invoice, please contact<br>[Accounting Department, +63 (917) 543-2109, accounting@beehive.xyz]
</body>
</html>
```

This will be the output of `file.html` when it is opened in a browser.

![html-output](/assets/images/posts/how-to-convert-html-to-pdf-in-php/html-output.jpg)

*Picture 1.1. The output of file.html in the browser.*

## Step 2: Download the TCPDF library.
You may download the TCPDF library on the following links:
* [GitHub](https://github.com/tecnickcom/tcpdf)
* [SourceForge](https://sourceforge.net/projects/tcpdf/)

This library will allow us to convert the HTML file that we have created into a PDF file format.

## Step 3: Create a PHP script file.
This PHP file will execute the library together with the HTML file to have a PDF output.

In this example, we will name it as `index.php`

```php
<?php
require_once('tcpdf/tcpdf.php');
$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
$pdf->SetPrintHeader(false);
$pdf->SetPrintFooter(false);
$pdf->AddPage();
$html = file_get_contents('file.html');
$pdf->writeHTML($html, true, false, true, false, '');
$pdf->lastPage();
$pdf->Output('file.pdf', 'D');
```

The code above will require the library in our file so that we can initialize the TCPDF class in the library.

The variable `$html` will hold the HTML file that we have created earlier and the library will do the rest to convert it to PDF.

The last line has two (2) parameters, the first parameter will be the filename of our PDF file while the second parameter is the action that we are going to do with the file.

There are many types of action that we can choose from for the second parameter. There are **I**, **D**, **F**, **S**, **FI**, **FD**, and **E**.

The **I** action is it will send the file inline with the browser, allowing it to be viewed in the browser without actually saving the file.

The **D** action means the file will be forced to be downloaded on the local machine given the filename in the first parameter.

The **F** action means the file will be saved on the local server that can be retrieved and downloaded later.

The **S** action will return the document as a string where the filename is ignored.

The **FI** action is the combination of F and I action. It will be both viewed in the browser and saved on the local server.

The **FD** action is the combination of F and D action. It will be both downloaded and saved on the local server.

The **E** action will return the document as a base64 mime multi-part email attachment ([RFC 2045](https://www.ietf.org/rfc/rfc2045.txt)). This is used when the file is going to be attached to an email.

In this example, we will choose to download the pdf file that we are going to create.

The directory will have 1 folder and 2 files.

![directory](/assets/images/posts/how-to-convert-html-to-pdf-in-php/directory.jpg)

*Picture 3.1. This is how the directory must look like.*

If you don’t have encountered an error when executing `index.php` then you must have the output as follows.

![pdf-output](/assets/images/posts/how-to-convert-html-to-pdf-in-php/pdf-output.jpg)

*Picture 3.2. The output of file.pdf opened in Google Chrome browser.*

That’s it, we have now converted an HTML file into a PDF file format document in PHP.
