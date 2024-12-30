-- Fixes Rust lifetimes such as &'a.
MiniPairs.map_buf(0, "i", "'", {
  action = "closeopen",
  pair = "''",
  neigh_pattern = "[^(%a|&)\\].",
  register = { cr = false },
})
