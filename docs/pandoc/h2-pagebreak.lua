-- When rendering to PDF via typst, start each "Layer N" section on a new
-- page, except the first one, which follows the introduction.
local seen = false

function Header(el)
  if el.level ~= 2 or not FORMAT:match("typst") then
    return nil
  end
  if not pandoc.utils.stringify(el):match("^Layer ") then
    return nil
  end
  if not seen then
    seen = true
    return nil
  end
  return { pandoc.RawBlock("typst", "#pagebreak()"), el }
end
