<b>2-download-button.lua:</b>

A KOReader patch that adds a download button for easy access to Zlibrary and rakuyomi. (Tested only on kobo, doesn't work on android)

You can of course modify the file to add more plugins in the section or to delete plugins you do not have.

Icon can be downloaded <a href="https://www.freepik.com/icon/download_4153059#fromView=search&page=1&position=62&uuid=4b164adc-06d4-406d-89ef-2fe006632a27">here</a>.
Place the icon in koreader/icons and rename it appbar.download.svg/png for it to work.

<img width="500" height="180" alt="FileManager_2025-11-12_105304" src="https://github.com/user-attachments/assets/49ebed1d-a6af-49d2-8940-dd75bd6d4288" />

<b>2-reader-header-print-edition-with-other-info.lua</b>

I prefer to have only my page number at the bottom of my screen, so I moved items such as clock, wifi and battery at the 
top of the screen instead of the original page numbers. Font used in my case is Cinzel. Font can be changed my modifying this:
    local header_font_face = "Cinzel-Regular.ttf"

Text font is my own handwritting, which you can download in the main repository.

<img width="1072" height="292" alt="Reader_The Time Travelers Wife (Au_ (Z-Library) epub_p514_2025-12-14_175559" src="https://github.com/user-attachments/assets/b72b3fd2-4762-43ee-8e42-cc8397e6b1a8" />

