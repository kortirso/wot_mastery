window.components.filter = () => {
  return {
    isOpen: false,
    toggle() { this.isOpen = !this.isOpen }
  }
}
