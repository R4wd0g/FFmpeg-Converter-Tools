# FFmpeg Converter Tools

Uma coleção de scripts batch para Windows que facilitam conversão, compressão e processamento de arquivos de vídeo e áudio usando FFmpeg.

## 🎯 Funcionalidades

- **Compressão de Vídeos** - Reduza o tamanho de arquivos MKV e MP4
- **Conversão de Formatos** - Converta entre diferentes codecs e containers
- **Remux de Containers** - Re-encapsule vídeos mantendo a qualidade original
- **Remoção de Legendas** - Remova tracks de legenda de vídeos MKV
- **Concatenação de Vídeos** - Una múltiplos arquivos MP4 em um único vídeo
- **Download Automático** - FFmpeg é baixado automaticamente na primeira execução

## 🖥️ Compatibilidade

- **Sistema Operacional**: Windows apenas
- **FFmpeg**: Baixado automaticamente (não é necessário instalar manualmente)

## 📦 Instalação

### Via Git Clone
```bash
# Clone o repositório
git clone https://github.com/R4wd0g/FFmpeg-Converter-Tools.git

# Navegue até o diretório
cd FFmpeg-Converter-Tools
```

### Download Manual
1. Acesse o repositório: [FFmpeg-Converter-Tools](https://github.com/R4wd0g/FFmpeg-Converter-Tools)
2. Clique em **Code** → **Download ZIP**
3. Extraia o arquivo ZIP em sua máquina

### Pós-Instalação
- Nenhuma configuração adicional é necessária
- FFmpeg será baixado automaticamente na primeira execução

## 📁 Estrutura de Ferramentas

### Compressor-MKV
Comprime vídeos em formato MKV usando codec H.265 (HEVC) com qualidade otimizada.
- **Entrada**: Arquivos `.mkv`
- **Saída**: Arquivos comprimidos em H.265

### Compressor-MP4
Comprime vídeos em formato MP4 usando codec H.265 (HEVC).
- **Entrada**: Arquivos `.mp4`
- **Saída**: Arquivos comprimidos em H.265

### Converter-AVI-to-MP4
Converte vídeos de AVI para MP4 usando codec H.264.
- **Entrada**: Arquivos `.avi`
- **Saída**: Arquivos `.mp4` em H.264

### Converter-H.265-to-H.264-MKV
Converte vídeos H.265 (HEVC) para H.264 mantendo o container MKV.
- **Entrada**: Arquivos de vídeo (`.mkv`, `.mp4`, etc.)
- **Saída**: Arquivos `.mkv` em H.264

### Converter-MKV-to-MP4
Converte vídeos de MKV para MP4 sem re-codificação (cópia de streams).
- **Entrada**: Arquivos `.mkv`
- **Saída**: Arquivos `.mp4`

### Converter-MP3-to-WAV
Converte áudio de MP3 para WAV.
- **Entrada**: Arquivos `.mp3`
- **Saída**: Arquivos `.wav`

### Converter-OGG-to-MP3
Converte áudio de OGG para MP3.
- **Entrada**: Arquivos `.ogg`
- **Saída**: Arquivos `.mp3`

### Cut-Video
Recorta trechos de vídeo com base no intervalo definido no nome do `.bat`.
- **Entrada**: Arraste o arquivo de vídeo para o `.bat`
- **Saída**: Arquivo no mesmo diretório com sufixo `-cut` (ou `-cut-2`, `-cut-3`...)

### Cut-Audio
Recorta trechos de áudio com base no intervalo definido no nome do `.bat`.
- **Entrada**: Arquivos `.mp3`, `.m4a`, `.wav`, `.flac`, `.ogg`, `.opus`
- **Saída**: Arquivo no mesmo diretório com sufixo `-cut` (ou `-cut-2`, `-cut-3`...)

### Remuxer
Re-encapsula vídeos em seu container original sem re-codificação, garantindo integridade do arquivo.
- **Entrada**: Qualquer formato suportado
- **Saída**: Mesmo arquivo remuxado

### Subtitles-Remover (Remove-Subtitles)
Remove todas as tracks de legendas de vídeos MKV.
- **Entrada**: Arquivos `.mkv`
- **Saída**: Arquivos `.mkv` sem legendas

### Concat-MP4
Concatena múltiplos vídeos MP4 em um único arquivo.
- **Entrada**: Múltiplos arquivos `.mp4`
- **Saída**: Um arquivo `merged.mp4`

## 🚀 Como Usar

### Método 1: DoubleClick (Automático)
1. Coloque seus arquivos de vídeo/áudio na pasta raiz da ferramenta desejada
2. Navegue até a pasta `worker`
3. Clique duas vezes em **"DoubleClick Version.bat"**
4. O processamento iniciará automaticamente para todos os arquivos na pasta

**Exemplo:**
```
Compressor-MKV/
├── video1.mkv
├── video2.mkv
└── worker/
    └── DoubleClick Version.bat  ← Duplo clique
```

### Método 2: Drag & Drop (Arrastar e Soltar)
1. Navegue até a pasta `worker` da ferramenta desejada
2. Arraste seus arquivos de vídeo/áudio diretamente sobre o arquivo **"Drag and Drop Version.bat"**
3. O processamento iniciará para os arquivos arrastados

**Exemplo:**
```
Arraste os arquivos → Solte sobre → worker/Drag and Drop Version.bat
```

## ⚙️ Processo de Funcionamento

1. **Verificação do FFmpeg**
   - O script verifica se o FFmpeg existe em `bin/ffmpeg.exe`
   - Se não encontrado, é baixado automaticamente via PowerShell

2. **Processamento**
   - Cada arquivo é processado sequencialmente
   - Um arquivo temporário é criado durante a conversão
   - O arquivo original é deletado após sucesso

3. **Finalização**
   - Um remux final é aplicado para garantir integridade do container
   - O arquivo final sobrescreve o original

## 📝 Exemplos de Uso

### Comprimir vídeo MKV
```batch
1. Coloque seu arquivo em: Compressor-MKV/
2. Duplo clique em: Compressor-MKV/worker/DoubleClick Version.bat
3. Espere o processamento completar
```

### Converter AVI para MP4
```batch
1. Arraste seu arquivo .avi para: Converter-AVI-to-MP4/worker/Drag and Drop Version.bat
2. Espere o processamento completar
```

### Remuxar múltiplos vídeos
```batch
1. Coloque os arquivos em: Remuxer/
2. Duplo clique em: Remuxer/worker/DoubleClick Version.bat
3. Todos os arquivos serão remuxados
```

### Recortar vídeo (Cut-Video)
```batch
1. Renomeie o .bat para o intervalo desejado (ex.: 00-00-06____00-00-15.bat)
2. Arraste o arquivo de vídeo sobre o .bat
3. O arquivo recortado sera salvo com sufixo -cut
```

### Recortar audio (Cut-Audio)
```batch
1. Renomeie o .bat para o intervalo desejado (ex.: 00-00-06____00-00-15.bat)
2. Arraste o arquivo de audio sobre o .bat
3. O arquivo recortado sera salvo com sufixo -cut
```

## ⚠️ Considerações Importantes

- **Backup**: Sempre faça backup dos arquivos originais antes do processamento
- **Tempo de Processamento**: Depende do tamanho do arquivo e performance do seu PC
- **Espaço em Disco**: Certifique-se de ter espaço livre suficiente durante o processamento
- **Extensões**: Respeite as extensões de entrada esperadas para cada ferramenta

## 📊 Codecs Utilizados

| Ferramenta | Vídeo | Áudio | Container |
|-----------|-------|-------|-----------|
| Compressor-MKV | H.265 (HEVC) | Copy | MKV |
| Compressor-MP4 | H.265 (HEVC) | Copy | MP4 |
| Converter-AVI-to-MP4 | H.264 (AVC) | AAC 192k | MP4 |
| Converter-H.265-to-H.264 | H.264 (AVC) | Copy | MKV |
| Converter-MKV-to-MP4 | Copy | Copy | MP4 |
| Cut-Video | Copy | Copy | Original |
| Cut-Audio | N/A | Copy | Original |
| Remuxer | Copy | Copy | Original |

