# Hello World in Android

Hello Word project, used as introduction to Android apps development in the elective course &quot;CPSC-3367 Mobile Apps Development&quot; from UA Little Rock

## Description

Very basic Android app with just only one activity. The layout of the activity is simply composed by three of the most common Android GUI elements: a TextEdit, a TextView and a Button.  
The user can input some text in the EditText element. When he taps the button the text is displayed through the TextView element.

## Branches

- <ins>1-hello-world.</ins> It provides the described functionality, using findViewById to get references to the several elements in the layout.
  
- <ins>2-hello-world-view-binding.</ins> It provides the same functionality, but it uses view binding in order to get reference of the elements in the layout from the Activity class.

## Get These Done:
- [x] TODO Change the package name of the app. New package name: com.ualr.firstapp
- [x] TODO Change the app name. New app name: First App
- [ ] TODO Change the app icon. The new icon will use the ic_countryimage drawable as foreground and light blue color as background
- [ ] TODO Set a new width value (120 dp) for the button with the "showBtn" id
- [ ] TODO Add a new property to the "showBtn" button to align the text within to the left side of the button
- [ ] TODO Avoid updating the text label ("uerMsgTV")when the user taps on 'show text'button and the text field("userInputET")is empty.
- [ ] TODO Create a new method called "cleanTextField"to delete the text inside the text field.
- [ ] TODO Add a new button with the"cleanBtn" idto the layout with the same properties of the show button (showBtn)
- [ ] TODO Link the "cleanBtn"to the "cleanTextField" method so whenever the user taps the button the text field gets cleaned
- [ ] TODO Modify the build configuration to make the app compatible with devices running an Android version above 14
