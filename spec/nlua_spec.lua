describe("nlua", function()
  it("can access vim.namespace", function()
    assert.are.same(vim.trim(" a"), "a")
  end)
end)
