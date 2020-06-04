#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Pandoc filter to process code blocks with class "plantuml" into
plant-generated images.

Needs `plantuml.jar` from http://plantuml.com/.
"""

import os
import sys
import subprocess

from pandocfilters import toJSONFilter, Para, Image, get_filename4code, get_caption, get_extension


def plantuml(key, value, format, _):
    if key == 'CodeBlock':
        [[ident, classes, keyvals], code] = value

        if "plantuml" in classes or "puml" in classes:
            caption, typef, keyvals = get_caption(keyvals)

            filename = get_filename4code("plantuml", code)
            #filetype = get_extension(format, "png", html5="svg", html="svg", latex="eps")
            filetype = get_extension(format, "png", html5="svg", html="svg", latex="png")

            src = filename + '.uml'
            dest = filename + '.' + filetype

            if not os.path.isfile(dest):
                # エンコード関連をコメントアウト
                # txt = code.encode(sys.getfilesystemencoding())
                # txt = str(code)
                txt = code

                if not txt.startswith("@start"):
                    txt = "@startuml\n" + txt + "\n@enduml\n"

                with open(src, "w") as f:
                    f.write(txt)

                # フィルターと同じディレクトリにplantuml.jarをおいておく
                plantuml_jar = os.path.join(os.path.dirname(__file__) , "plantuml.jar")

                # subprosess.callから変更
                subprocess.run(["java", "-jar", plantuml_jar, "-t"+filetype, src])
                sys.stderr.write('Created image ' + dest + '\n')

            return Para([Image([ident, [], keyvals], caption, [dest, typef])])

if __name__ == "__main__":
    toJSONFilter(plantuml)
    