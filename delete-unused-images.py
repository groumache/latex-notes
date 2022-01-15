####################################
# This was made to work on Windows #
####################################


# NOTE: files that have the same name in different folders will not be deleted


from os import scandir, mkdir
from typing import List
from pathlib import Path


image_extensions: List[str] = ['jpg', 'jpeg', 'png', 'svg', 'gif', 'JPG', 'JPEG', 'PNG', 'SVG', 'GIF']
dir_with_latex: str = "C:\\Users\\groum\\Documents\\Latex\\github-latex\\sécurité-offensive\\"
dir_list: List[str] = [dir_with_latex]
image_list: List[str] = []
latex_list: List[str] = []
included_images: List[str] = []
to_be_deleted_images: List[str] = []


def is_file_an_image(file: str) -> bool:
    extension: str = file.split('.')[-1]
    return (extension in image_extensions)

def is_file_latex(file: str) -> bool:
    extension: str = file.split('.')[-1]
    return (extension == 'tex')


def get_latex_image(text_line: str) -> str:
    # examples of text_line :
    #   \includegraphics[width=5cm]{images/LogoHenallux.PNG}~\\[1.5cm]
    #   \includegraphics{images/LogoHenallux.PNG}
    #   \begin{center} \includegraphics{images.PNG} \end{center}
    if "includegraphics" not in text_line: return

    try: i_start: int = text_line.index("]{") + 2
    except: i_start = text_line.index("includegraphics{") + 16
    i_end: int = text_line.index("}", i_start)

    image = text_line[i_start:i_end]
    return image


def test_get_latex_image():
    assert get_latex_image("\includegraphics[width=5cm]{images/LogoHenallux.PNG}~\\[1.5cm]") == "images/LogoHenallux.PNG"
    assert get_latex_image("\includegraphics{images/LogoHenallux.PNG}") == "images/LogoHenallux.PNG"
    assert get_latex_image("\begin{center} \includegraphics{images.PNG} \end{center}") == "images.PNG"


# 1. get every latex file and images
i: int = 0
while i < len(dir_list):
    dir: str = dir_list[i]
    for file in scandir(dir):
        if file.is_dir(): dir_list.append(file.path)
        if file.is_file() and is_file_an_image(file.name): image_list.append(file.path)
        if file.is_file() and is_file_latex(file.name): latex_list.append(file.path)
    i += 1


# 2. get every image in the latex documents
for latex in latex_list:
    with open(latex, 'r') as f:
        for line in f:
            image = get_latex_image(line)
            if image is not None: included_images.append(image.split('/')[-1])


# 3. get the non-included images
for image in image_list:
    if image.split('\\')[-1] not in included_images:
        to_be_deleted_images.append(image)


# 4. create a directory for the images to be deleted and move them there
to_be_deleted_dir: str = dir_with_latex + 'to-be-deleted'
try: mkdir(to_be_deleted_dir)
except: pass
for image in to_be_deleted_images:
    print(image)
    Path(image).rename(to_be_deleted_dir + '\\' + image.split('\\')[-1])





