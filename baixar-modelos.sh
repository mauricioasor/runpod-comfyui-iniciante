#!/usr/bin/env bash
# Baixa os modelos do tutorial (Z-Image Turbo + Wan 2.2 5B) para o ComfyUI do Pod. Uns 36 GB.
# Uso no terminal do Pod:  bash baixar-modelos.sh
set -e
COMFY=$(find /workspace / -maxdepth 4 -type d -name ComfyUI -path "*ComfyUI" 2>/dev/null | head -1)
if [ -z "$COMFY" ]; then echo "Não achei a pasta do ComfyUI."; exit 1; fi
echo "ComfyUI encontrado em: $COMFY"
M="$COMFY/models"
baixar() {  # pasta  url
  mkdir -p "$M/$1"; arq="$M/$1/$(basename "$2")"
  if [ -s "$arq" ]; then echo "Já existe: $(basename "$2")"; return; fi
  echo "Baixando $(basename "$2")..."
  wget -q --show-progress -c -O "$arq.part" "$2" && mv "$arq.part" "$arq"
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
