-- l3build configuration for TikZ-UMLD.
--
--   l3build check     run the regression tests (testfiles/) on all engines
--   l3build doc       typeset the manual and the examples into doc/
--   l3build ctan      run the tests, then build the CTAN archive tikz-umld-ctan.zip
--   l3build upload 1.2.3  validate and upload that archive to CTAN
--   l3build tag 1.2.3 stamp a version and date into the sources (see below)
--   l3build clean     remove build files

module = "tikz-umld"

sourcefiles  = {"tikz-umld.sty"}
installfiles = {"tikz-umld.sty"}
unpackfiles  = {}

textfiles = {"README.md", "CHANGELOG.md", "LICENSE.md", "NOTICE.md"}
ctanreadme = "README.md"

-- Documentation lives in doc/; the examples are typeset and shipped with it.
docfiledir = "doc"
flatten = false

local examples = {
  "classdiag", "componentdiag", "seqdiag", "statediag",
  "usecasediag", "umld-features", "full",
}
typesetfiles = {"tikz-umld-userguide.tex"}
docfiles = {
  "tikz-umld-doc-style.sty", "tikz-umld-listings-style.sty", "fig",
  "examples/*.pdf", -- built by typeset_demo_tasks() below
}
demofiles = {"examples/*.tex"}

-- The examples sit in doc/examples/. l3build mangles the output directory of
-- typeset demo files in a subdirectory, so typeset them in this hook instead.
function typeset_demo_tasks()
  for _, name in ipairs(examples) do
    local errorlevel = cp("examples/" .. name .. ".tex", docfiledir, typesetdir)
    if errorlevel ~= 0 then return errorlevel end
    errorlevel = typeset(name .. ".tex", typesetdir)
    if errorlevel ~= 0 then return errorlevel end
    errorlevel = cp(name .. ".pdf", typesetdir, docfiledir .. "/examples")
    if errorlevel ~= 0 then return errorlevel end
  end
  return 0
end

checkengines = {"pdftex", "xetex", "luatex"}
stdengine    = "pdftex"

tagfiles = {"tikz-umld.sty"}

function update_tag(file, content, tagname, tagdate)
  if not tagname then return content end
  local version = tagname:gsub("^v", "")
  return (content:gsub("(\\ProvidesPackage{tikz%-umld}%[)%S+ %S+",
    function(head)
      return head .. tagdate:gsub("%-", "/") .. " v" .. version
    end))
end

if os.getenv("L3BUILD_CTAN_UPLOAD") == "yes" then
  ctanupload = true
end
uploadconfig = {
  pkg         = module,
  author      = "David Imolai",
  uploader    = "David Imolai",
  license     = "agpl3",
  ctanPath    = "/graphics/pgf/contrib/tikz-umld",
  summary     = "Draw UML diagrams with TikZ",
  description = [[TikZ-UMLD is a TikZ-based LaTeX package for class, package, object, use-case, state, sequence, and component diagrams. It is a maintained derivative of TikZ-UML 1.0 with object-diagram support, two-compartment enumerations, UML constraints, pointed notes, enhanced relationship stereotypes, and rendering fixes.]],
  repository  = "https://github.com/imol-ai/tikz-umld",
  bugtracker  = "https://github.com/imol-ai/tikz-umld/issues",
  update      = true,
}
