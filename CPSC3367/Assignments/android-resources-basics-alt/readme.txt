[X] - TODO 1: Replace hardcoded numeric values with dimen
              resources (Obviously, you'll have to create a dimens file).

[X]- TODO 2: Replace hardcoded strings with string resources for every GUI text component, with the
              exception of the TextView with the "country_description_text" id.

[ ] - TODO 3: Define  the  alternative  resources  needed  to  have  different  content  and  look
              and  feel depending on the device language.

[ ] - TODO 4: Get the description string value from resources

[ ] - TODO 5: Initialize the text property of the TextView element with the
              "country_description_text" id by using the value retrieved in the previous point.

[ ] - TODO 6: Define  button_color resource.  Remember,  the  button  will  have  a  specific  color
              for pressed state and another one for the rest

[ ] - TODO 7: Add a new layout for the MainActivity to be displayed on landscape orientation.

[ ] - TODO 8: Make  sure  the  appropriate  bitmap  image  is  displayed  for  the  two  considered
              languages.



<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:state_pressed="true" android:backgroundTint="@color/button_pressed"/>
    <item android:backgroundTint="@color/button_color"/>
</selector>