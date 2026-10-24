# RunPod + ComfyUI do zero

Arquivos do vídeo do YouTube: alugar uma placa de vídeo por hora no RunPod e gerar imagens e vídeos com IA no ComfyUI.

## Arquivos

| Arquivo | O que faz |
|---|---|
| `baixar-modelos.sh` | Baixa os modelos (~36 GB) para a pasta do ComfyUI do Pod |
| `workflows/1-imagem-z-image-turbo.json` | Texto → imagem 1024×1024 com o Z-Image Turbo |
| `workflows/2-video-wan22-5b.json` | Imagem → vídeo (~5 s) com o Wan 2.2 TI2V 5B |

## Como usar

1. No RunPod, crie um Pod com o template **ComfyUI** (oficial) e uma placa de 24 GB (RTX 4090 ou A5000).
2. Abra o terminal do Pod e rode:
   ```bash
   wget -O baixar-modelos.sh https://raw.githubusercontent.com/mauricioasor/runpod-comfyui-iniciante/main/baixar-modelos.sh && bash baixar-modelos.sh
   ```
3. No ComfyUI, aperte **R** para recarregar os modelos.
4. Arraste um dos arquivos `.json` da pasta `workflows` para a tela do ComfyUI e clique em **Run**.

## Créditos

Workflows baseados nos modelos oficiais do ComfyUI ([Comfy-Org/workflow_templates](https://github.com/Comfy-Org/workflow_templates)). Os modelos são baixados direto do Hugging Face da Comfy-Org e seguem as licenças de cada modelo.

Preços e regras do RunPod mudam; confira em https://www.runpod.io antes de usar.
