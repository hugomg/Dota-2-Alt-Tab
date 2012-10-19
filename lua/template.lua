--[==[

--template: recebe um objeto de dados e cospe uma string.

VALUE() -> imprime um objeto Lua (string ou inteiro)
ATTR()  -> imprime um atributo do objeto de dados

CONCAT({ ... })

FOR( expr){} -> itera e altera o objeto de dados

--]==]

EXPR = function(evalf) return function(val)
  return {
    eval = evalf,
    run = function(self, obj, printf)
      printf(tostring(evalf(self, obj, val)))
    end
  }
end end

VALUE = EXPR(function(self, obj, x) return x end)
ATTR = EXPR(function(self, obj, x) return obj[x] end)

CONCAT = function(tmpls)
  return {
    run = function(self, obj, printf)
      for _, tmpl in ipairs(tmpls) do
        tmpl:run(obj, printf)
      end
    end
  }
end

FOR = function(expr) return function(tmpls)
  local block = CONCAT(tmpls)
  return {
    run = function(self, obj, printf)
      for i, inner_obj in ipairs( expr:eval(obj) ) do
        return block:run(inner_obj, printf)
      end
    end
  }
end end

TAG = function(tagname) return function(tmpls)
  ts = {}
  table.insert(ts, VALUE('<'..tagname..'>'))
  for _, tmpl in ipairs(tmpls) do table.insert(ts, tmpl) end
  table.insert(ts, VALUE('</'..tagname..'>'))
  
  return CONCAT(ts)
end end
  

-------

--[==[

tmp = CONCAT{
  TAG 'div' {VALUE("Hello World"), VALUE(17), ATTR('a') }
}

data = { a="A", b="B" }

tmp:run(data, io.write)
print()



TAG ('div', 'class', 'section taverns') {
  
  FOR (OBJ) {
    FOR (OBJ) {
      TAG ('div', 'class', 'tavern') {
        
        TAG ('h3', 'class', A'stat') {
          SPRITE 'tavern' {T'stat_', A'stat'}),
          ATTR 'name',
          SPRITE 'tavern' {T'team_', A'team'},
        }
        
        TAG 'table', { FOR(OBJ) {
          TAG 'tr', { FOR(OBJ) {
            TAG 'td' {
              TAG ('a', 'href', {T'#', A'id'}, 'class', 'nav'), {
                SPRITE 'hero' { 
                  T"Go to the ", A'fullName', T" guide",
                }
              }
            }
            }
        }}}}
  }}}
}

--]==]

function go(n)

  local odd, even

  even = function(n)
    if n == 0 then return true 
              else return odd(n-1) end
  end

  odd = function(n)
    if n == 0 then return false
              else return even(n-1) end
  end

  print(even(n), odd(n))
  
end

go(1)
go(2)

function test()
  local foo
  foo = bar
  
  local bar = 10
  
  return foo
end