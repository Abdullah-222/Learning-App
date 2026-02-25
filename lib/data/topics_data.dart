import 'package:secure_learning_app/models/topic_model.dart';

class TopicsData {
  static const List<Topic> topics = [
    Topic(
      id: 'buffer_overflow',
      title: 'Buffer Overflow',
      description: 'Writing data past the end of a buffer, corrupting adjacent memory.',
      iconAsset: 'assets/icons/buffer_overflow.png',
      videoUrl: 'https://www.youtube.com/watch?v=1S0aBV-Waeo',
      questions: [
        QuizQuestion(
          question: 'What is a Buffer Overflow?',
          options: [
            'Running out of RAM',
            'Writing more data than a buffer can hold',
            'A stack trace error',
            'A recursive function loop'
          ],
          correctIndex: 1,
          explanation: 'A buffer overflow occurs when a program writes data beyond the allocated memory limit of a buffer.',
        ),
         QuizQuestion(
          question: 'Which function is unsafe to use due to buffer overflow risks?',
          options: [
            'fgets()',
            'strcpy()',
            'strncpy()',
            'snprintf()'
          ],
          correctIndex: 1,
          explanation: 'strcpy() does not check the destination buffer size, making it prone to overflows. Use strncpy() or safe alternatives.',
        ),
        QuizQuestion(
          question: 'What can an attacker achieve with a stack-based buffer overflow?',
          options: [
            'Change the text color',
            'Execute arbitrary code',
            'Speed up the CPU',
            'Format the hard drive'
          ],
          correctIndex: 1,
          explanation: 'By overwriting the return address on the stack, attackers can redirect program execution to malicious code.',
        ),
        QuizQuestion(
          question: 'What is a "canary" in the context of buffer overflows?',
          options: [
            'A bird that sings when code runs',
            'A value placed on the stack to detect corruption',
            'A hacking tool',
            'A type of virus'
          ],
          correctIndex: 1,
          explanation: 'Stack canaries are known values placed between a buffer and control data. If the canary is changed, an overflow occurred.',
        ),
        QuizQuestion(
          question: 'Which language is most susceptible to buffer overflows?',
          options: [
            'Python',
            'Java',
            'C/C++',
            'Rust'
          ],
          correctIndex: 2,
          explanation: 'C and C++ allow direct memory manipulation without built-in bounds checking, unlike modern managed languages.',
        ),
      ],
    ),
    Topic(
      id: 'memory_leak',
      title: 'Memory Leaks',
      description: 'Failure to release allocated memory, leading to resource exhaustion.',
      iconAsset: 'assets/icons/memory_leak.png',
      videoUrl: 'https://www.youtube.com/watch?v=eu_kTGv61WQ',
      questions: [
        QuizQuestion(
          question: 'When does a memory leak occur?',
          options: [
            'When memory is not initialized',
            'When allocated memory is not freed',
            'When a pointer is set to NULL',
            'When the disk is full'
          ],
          correctIndex: 1,
          explanation: 'A memory leak happens when a program allocates memory (e.g., malloc/new) but fails to deallocate it (free/delete).',
        ),
         QuizQuestion(
          question: 'Which C++ keyword is used to release memory allocated with "new"?',
          options: [
            'remove',
            'free',
            'delete',
            'clear'
          ],
          correctIndex: 2,
          explanation: 'In C++, "delete" is used to free memory allocated with "new". "free" is used with "malloc".',
        ),
        QuizQuestion(
          question: 'What is a consequence of severe memory leaks?',
          options: [
            'Faster execution',
            'System crash or slowdown (OOM)',
            'Corrupted files',
            'Network failure'
          ],
          correctIndex: 1,
          explanation: 'Memory leaks consume available RAM, eventually leading to Out Of Memory (OOM) errors and system crashes.',
        ),
        QuizQuestion(
          question: 'Which tool can detect memory leaks?',
          options: [
            'Valgrind',
            'GDB',
            'Vim',
            'Git'
          ],
          correctIndex: 0,
          explanation: 'Valgrind is a popular tool for memory debugging, memory leak detection, and profiling.',
        ),
        QuizQuestion(
          question: 'What is RAII in C++?',
          options: [
            'Random Access Input Interface',
            'Resource Acquisition Is Initialization',
            'Rapid Application Interface Integration',
            'Nothing'
          ],
          correctIndex: 1,
          explanation: 'RAII ensures that resources (like memory) are acquired in a constructor and released in the destructor, preventing leaks.',
        ),
      ],
    ),
    Topic(
      id: 'pointer_misuse',
      title: 'Pointer Misuse',
      description: 'Incorrect use of pointers leading to crashes or security flaws.',
      iconAsset: 'assets/icons/pointer.png',
      videoUrl: 'https://www.youtube.com/watch?v=qNgV7oAHElk',
      questions: [
        QuizQuestion(
          question: 'What is a dangling pointer?',
          options: [
            'A pointer that points to NULL',
            'A pointer referencing freed memory',
            'A pointer to a function',
            'A global pointer'
          ],
          correctIndex: 1,
          explanation: 'A dangling pointer points to a memory location that has already been freed, leading to undefined behavior if accessed.',
        ),
        QuizQuestion(
          question: 'What is a Double Free error?',
          options: [
            'Calling free() twice on the same pointer',
            'Allocating double the memory',
            'Getting two pointers for free',
            'Using a double variable'
          ],
          correctIndex: 0,
          explanation: 'Calling free() on the same memory address twice corrupts the heap management structures.',
        ),
        QuizQuestion(
          question: 'What happens if you dereference a NULL pointer?',
          options: [
            'It returns 0',
            'The program crashes (Segfault)',
            'It prints "NULL"',
            'Nothing happens'
          ],
          correctIndex: 1,
          explanation: 'Dereferencing a NULL pointer causes a Segmentation Fault because 0x0 is not a valid memory address for access.',
        ),
        QuizQuestion(
          question: 'How can you prevent dangling pointers?',
          options: [
            'Never use pointers',
            'Set pointers to NULL after freeing',
            'Use global variables',
            'Cast them to void*'
          ],
          correctIndex: 1,
          explanation: 'Setting a pointer to NULL after calling free() ensures that accidental subsequent access is easily detected or handled safely.',
        ),
        QuizQuestion(
          question: 'What is "Use After Free"?',
          options: [
            'Using free software',
            'Accessing memory after it has been freed',
            'Checking memory before freeing',
            'Allocating memory after freeing'
          ],
          correctIndex: 1,
          explanation: 'Use After Free (UAF) is a vulnerability where a program uses a pointer after the memory it points to has been freed.',
        ),
      ],
    ),
    Topic(
      id: 'integer_overflow',
      title: 'Integer Overflow',
      description: 'Arithmetic operations producing values too large for the data type.',
      iconAsset: 'assets/icons/integer.png',
      videoUrl: 'https://www.youtube.com/watch?v=Dbbh_lrbgAU',
      questions: [
        QuizQuestion(
          question: 'What happens when an unsigned integer overflows?',
          options: [
            'It stops at the max value',
            'It wraps around to 0',
            'The program crashes',
            'It becomes negative'
          ],
          correctIndex: 1,
          explanation: 'Unsigned integers wrap around to 0 (modulo arithmetic) when they exceed their maximum value.',
        ),
        QuizQuestion(
          question: 'What happens when a signed integer overflows in C/C++?',
          options: [
            'It wraps around',
            'It is Undefined Behavior (UB)',
            'It throws an exception',
            'It stays at max'
          ],
          correctIndex: 1,
          explanation: 'Signed integer overflow is Undefined Behavior in C/C++, meaning the compiler can assume it never happens, leading to bugs.',
        ),
        QuizQuestion(
          question: 'Which attack can be enabled by an integer overflow?',
          options: [
            'SQL Injection',
            'Heap Overflow via small allocation size',
            'Phishing',
            'Man in the middle'
          ],
          correctIndex: 1,
          explanation: 'If an overflow wraps a size calculation to a small number, a small buffer is allocated, but large data is copied, causing a heap overflow.',
        ),
        QuizQuestion(
          question: 'If an 8-bit unsigned char has value 255 and you add 1, what is the result?',
          options: [
            '256',
            '0',
            '-1',
            'Error'
          ],
          correctIndex: 1,
          explanation: '255 is the max value for 8-bit. Adding 1 wraps it around to 0.',
        ),
        QuizQuestion(
          question: 'How do you prevent integer overflows?',
          options: [
            'Use larger types',
            'Check operands before arithmetic',
            'Only use small numbers',
            'Disable math'
          ],
          correctIndex: 1,
          explanation: 'Always validate input ranges and check if an operation would exceed limits before performing it.',
        ),
      ],
    ),
    Topic(
      id: 'null_pointer',
      title: 'Null Pointer Dereference',
      description: 'Attempting to read or write memory using a null pointer.',
      iconAsset: 'assets/icons/null_pointer.png',
      videoUrl: 'https://www.youtube.com/watch?v=oPScHNQDCkc',

      questions: [
        QuizQuestion(
            question: "What is a Null Pointer?",
            options: [
                "A pointer to the end of a file",
                "A pointer that does not point to any valid memory object",
                "A pointer to a function",
                "A pointer with value 1"
            ],
            correctIndex: 1,
            explanation: "A null pointer has a reserved value (usually 0) indicating that it refers to no object."
        ),
        QuizQuestion(
            question: "Does 'malloc' always return a valid pointer?",
            options: [
                "Yes, always",
                "No, it returns NULL if memory is full",
                "It returns -1 on failure",
                "It throws an exception"
            ],
            correctIndex: 1,
            explanation: "If the system cannot allocate the requested memory, malloc returns NULL. Always check the result!"
        ),
        QuizQuestion(
            question: "Why is NULL usually defined as 0?",
            options: [
                "It is the first memory address",
                "Address 0 is reserved by the OS to trap invalid access",
                "It's easier to type",
                "No reason"
            ],
            correctIndex: 1,
            explanation: "Modern OSs map the zero page as inaccessible so that any attempt to access address 0 causes a hardware fault."
        ),
        QuizQuestion(
            question: "How do you safely use a pointer that might be NULL?",
            options: [
                "Just use it",
                "Check if (ptr != NULL) before dereferencing",
                "Cast it to int",
                "Print it"
            ],
            correctIndex: 1,
            explanation: "Always check if a pointer is valid (not null) before trying to access the memory it points to."
        ),
        QuizQuestion(
            question: "In C++, what is 'nullptr'?",
            options: [
                "A variable name",
                "A type-safe null pointer constant introduced in C++11",
                "A macro for 0",
                "A library function"
            ],
            correctIndex: 1,
            explanation: "nullptr is a keyword in C++11 that represents a null pointer literal, providing better type safety than 0 or NULL."
        ),
      ]
    ),
    Topic(
      id: 'input_validation',
      title: 'Input Validation',
      description: 'Failure to properly check user input, leading to injections and crashes.',
      iconAsset: 'assets/icons/input.png',
      videoUrl: 'https://www.youtube.com/watch?v=fhckQsZM9oQ',
      questions: [
        QuizQuestion(
            question: "Why should you never trust user input?",
             options: [
                "Users are always malicious",
                "Input might be malformed or malicious",
                "It takes too long to read",
                "Computers don't like users"
            ],
            correctIndex: 1,
            explanation: "Input from external sources can be anything. If not validated, it can exploit vulnerabilities (SQLi, XSS, Overflow)."
        ),
        QuizQuestion(
             question: "What is a whitelist approach to validation?",
             options: [
                 "Allowing everything except known bad chars",
                 "Allowing only known good characters/patterns",
                 "Coloring the text white",
                 "Using a white background"
             ],
             correctIndex: 1,
             explanation: "Whitelisting is safer because you define strictly what is allowed, rejecting everything else by default."
        ),
        QuizQuestion(
             question: "What is SQL Injection?",
             options: [
                 "Inserting a virus into the database",
                 "Injecting malicious SQL commands via input fields",
                 "Updating the database quickly",
                 "A medical procedure"
             ],
             correctIndex: 1,
             explanation: "Attackers interfere with the queries an application makes to its database by injecting their own SQL code."
        ),
        QuizQuestion(
             question: "How does input validation prevent buffer overflows?",
             options: [
                 "It makes buffers larger",
                 "It ensures input length does not exceed buffer size",
                 "It encrypts the buffer",
                 "It deletes the buffer"
             ],
             correctIndex: 1,
             explanation: "Checking the length of input ensures it fits into the destination buffer before copying."
        ),
        QuizQuestion(
             question: "Where should input validation happen?",
             options: [
                 "Client side only",
                 "Server side only",
                 "Both Client and Server/Application side",
                 "Nowhere"
             ],
             correctIndex: 2,
             explanation: "Client-side creates a good UX, but Server/App-side validation is strictly required for security so attackers can't bypass it."
        ),
      ]
    ),
    Topic(
      id: 'unsafe_functions',
      title: 'Unsafe Functions',
      description: 'Using dangerous standard library functions that lack bounds checking.',
      iconAsset: 'assets/icons/unsafe.png',
      videoUrl: 'https://www.youtube.com/watch?v=Qyn1qxi73u8',
      questions: [
        QuizQuestion(
            question: "Why is 'gets()' removed from modern C standards?",
            options: [
                "It is too slow",
                "It is impossible to prevent buffer overflows with it",
                "It was hard to spell",
                "It didn't work"
            ],
            correctIndex: 1,
            explanation: "gets() reads input until a newline without checking the buffer size. It is inherently insecure."
        ),
        QuizQuestion(
            question: "What is a safer alternative to 'sprintf'?",
            options: [
                "printf",
                "snprintf",
                "print",
                "write"
            ],
            correctIndex: 1,
            explanation: "snprintf takes the buffer size as an argument, preventing it from writing past the end of the buffer."
        ),
        QuizQuestion(
            question: "Why can 'Use of Unsafe Functions' be flagged by static analysis?",
            options: [
                "They are deprecated and known to be risky",
                "Compilers don't like them",
                "They are too old",
                "They use too much CPU"
            ],
            correctIndex: 0,
            explanation: "Tools know that functions like strcpy, strcat, etc. are common sources of bugs and flag them for review."
        ),
        QuizQuestion(
            question: "What does 'strcat' do that is dangerous?",
            options: [
                "Concatenates strings without checking destination size",
                "Deletes strings",
                "Reverses strings",
                "Encrypts strings"
            ],
            correctIndex: 0,
            explanation: "Like strcpy, strcat assumes the destination buffer is large enough, which often leads to overflows."
        ),
        QuizQuestion(
            question: "What is the best way to handle strings in C++ to avoid these issues?",
            options: [
                "Use std::string",
                "Use char arrays",
                "Use void pointers",
                "Use assembly"
            ],
            correctIndex: 0,
            explanation: "std::string manages memory automatically and provides safe methods, avoiding most manual buffer management errors."
        ),
      ]
    ),
  ];
}
