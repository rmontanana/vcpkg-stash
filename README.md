# Private vcpkg Registry: vcpkg-stash

Welcome to the **vcpkg-stash** private registry! 🚀

This repository provides prebuilt or custom libraries for projects that use **vcpkg** as their package manager.

---

## 📁 Libraries Included

- `BayesNet`    — A C++ library for Bayesian networks (https://gitea.rmontanana.es/rmontanana/bayesnet).
- `folding`     — A C++ library for folding datasets (https://gitea.rmontanana.es/rmontanana/folding).
- `arff-files`  — A C++ library to read ARFF datasets (https://gitea.rmontanana.es/rmontanana/ArffFiles).
- `fimdlp`      — A C++ library with Discretization algorithm based on the paper by Fayyad & Irani and some binning discretization algorithms (depends on `arff-files`). (https://gitea.rmontanana.es/rmontanana/mdlp).
- `libtorch-bin` — Pre-built binaries of **LibTorch** (PyTorch C++ API) (https://pytorch.org/) for:
  - Linux x86-64 (CPU)
  - macOS ARM64 (Apple Silicon)

---

## 🔗 How to Configure Your Project to Use This Registry

### 1. Ensure you are using a recent version of **vcpkg** (>=2024.01.10).

### 2. In your project, create (or edit) a file named **`vcpkg-configuration.json`** at the project root:

```json
{
  "registries": [
    {
      "kind": "git",
      "repository": "https://github.com/rmontanana/vcpkg-stash",
      "baseline": "18ddd10b8c7613a217ce6651aae7c3d778c88729",
      "packages": [
        "arff-files",
        "fimdlp",
        "libtorch-bin"
      ]
    }
  ],
  "default-registry": {
    "kind": "git",
    "repository": "https://github.com/microsoft/vcpkg",
    "baseline": "760bfd0c8d7c89ec640aec4df89418b7c2745605"
  }
}
```

- Replace the Microsoft baseline if needed to match your local vcpkg clone.
- This setup tells vcpkg to fetch `arff-files`, `fimdlp`, and `libtorch-bin` from **vcpkg-stash**, and everything else from the official **microsoft/vcpkg** registry.

### 3. Install dependencies normally:

```bash
vcpkg install
```

### 4. In your CMake project, link libraries as usual, e.g.:

```cmake
find_package(Torch CONFIG REQUIRED)
find_package(fimdlp CONFIG REQUIRED)
find_path(ARFF_FILES_INCLUDE_DIRS "ArffFiles/ArffFiles.hpp" REQUIRED)
include_directories(${TORCH_INCLUDE_DIRS} ${ARFF_FILES_INCLUDE_DIRS} ${fimdlp_INCLUDE_DIRS})

add_executable(myapp main.cpp)

target_link_libraries(myapp PRIVATE ${TORCH_LIBRARIES} fimdlp::fimdlp)
```


---

## 👌 Notes

- `libtorch-bin` uses prebuilt binaries — no need to compile LibTorch from source!
- Make sure to match your project's **triplet** (e.g., `x64-linux`, `arm64-osx`) to the prebuilt architecture available.
- If you update the registry, remember to update the **baseline** commit SHA in your `vcpkg-configuration.json`.

---

## 🚀 Future Improvements

- Add automatic updates for new LibTorch versions.
- Add usage hints for easier `find_package` with CMake.
- Expand prebuilt support to Windows if needed.

---

Happy building! 🎉


