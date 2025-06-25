import tkinter as tk

# Correct unlock code
CORRECT_CODE = "8675"

class FullscreenLock:
    def __init__(self, root):
        self.root = root
        self.root.attributes('-fullscreen', True)
        self.root.configure(bg='black')

        self.entered_code = tk.StringVar()

        self.create_widgets()

    def create_widgets(self):
        # Display field
        display = tk.Entry(self.root, textvariable=self.entered_code, font=("Arial", 36), justify="center", bd=6, relief="sunken", show="*", state='readonly')
        display.pack(pady=50, ipadx=10, ipady=10)

        # Keypad buttons
        btn_frame = tk.Frame(self.root, bg="black")
        btn_frame.pack()

        # Digits layout
        digits = [
            '1', '2', '3',
            '4', '5', '6',
            '7', '8', '9',
            'DEL', '0', 'OK'
        ]

        for i, digit in enumerate(digits):
            action = lambda x=digit: self.handle_input(x)
            b = tk.Button(btn_frame, text=digit, font=("Arial", 28), width=5, height=2, command=action)
            b.grid(row=i//3, column=i%3, padx=10, pady=10)

    def handle_input(self, key):
        if key == "DEL":
            current = self.entered_code.get()
            self.entered_code.set(current[:-1])
        elif key == "OK":
            if self.entered_code.get() == CORRECT_CODE:
                self.root.destroy()
            else:
                self.entered_code.set("")
        else:
            if len(self.entered_code.get()) < 8:
                self.entered_code.set(self.entered_code.get() + key)

if __name__ == "__main__":
    root = tk.Tk()
    app = FullscreenLock(root)
    root.mainloop()
