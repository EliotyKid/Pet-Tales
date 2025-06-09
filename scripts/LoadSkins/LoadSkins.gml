function LoadSkins() {
  var _filePath = SKINS_FILE;
  if (file_exists(_filePath)) {
    var _buffer = buffer_load(_filePath);
    var _strin = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);

    if (string_length(_strin) > 0) {
      global.skins = json_parse(_strin);
      show_debug_message("Skins carregadas:");
      show_debug_message(json_stringify(global.skins));
    } else {
      show_message("skins.dat está vazio!");
      global.skins = {};
    }
  } else {
    show_message("skins.dat não encontrado!");
    global.skins = {};
  }
}
