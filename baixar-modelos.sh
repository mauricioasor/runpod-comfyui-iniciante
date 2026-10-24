#!/usr/bin/env bash
# Baixa os modelos do tutorial (Z-Image Turbo + Wan 2.2 5B) para o ComfyUI do Pod. Uns 36 GB.
# Uso no terminal do Pod:  bash baixar-modelos.sh
# Usa o aria2 (várias conexões por arquivo, bem mais rápido). Se não tiver, tenta instalar; senão usa o wget.
set -e
COMFY=$(find /workspace / -maxdepth 4 -type d -name ComfyUI -path "*ComfyUI" 2>/dev/null | head -1)
if [ -z "$COMFY" ]; then echo "Não achei a pasta do ComfyUI."; exit 1; fi
echo "ComfyUI encontrado em: $COMFY"
M="$COMFY/models"

if ! command -v aria2c >/dev/null 2>&1; then
  echo "Instalando o aria2 (download acelerado)..."
  (apt-get update -qq && apt-get install -y -qq aria2) >/dev/null 2>&1 || echo "Não deu para instalar o aria2; vou usar o wget (mais lento)."
fi

baixar() {  # pasta  url
  mkdir -p "$M/$1"; nome="$(basename "$2")"; arq="$M/$1/$nome"
  if [ -s "$arq" ] && [ ! -e "$arq.aria2" ] && [ ! -e "$arq.part" ]; then echo "Já existe: $nome"; return; fi
  rm -f "$arq.part"
  echo "Baixando $nome..."
  if command -v aria2c >/dev/null 2>&1; then
    aria2c -x 16 -s 16 -k 10M -c --console-log-level=warn --summary-interval=0 --download-result=hide -d "$M/$1" -o "$nome" "$2"
  else
    wget -q --show-progress -c -O "$arq" "$2"
  fi
}
HF=https://huggingface.co/Comfy-Org
# Imagem: Z-Image Turbo
baixar text_encoders    $HF/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors
baixar diffusion_models $HF/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors
baixar vae              $HF/z_image_turbo/resolve/main/split_files/vae/ae.safetensors
# Vídeo: Wan 2.2 TI2V 5B
baixar diffusion_models $HF/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors
baixar vae              $HF/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan2.2_vae.safetensors
baixar text_encoders    $HF/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors
echo "Pronto! Atualize o ComfyUI no navegador (tecla R) e rode os workflows."
