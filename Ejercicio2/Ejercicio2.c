#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h>

// Juan Pedro Puig - 281088
// Pedro Azambuja - 270218

sem_t sem1, sem1b, sem2, sem3a, sem3b, sem3c, sem3d, sem4, sem5a, sem5b, sem5c, sem6, sem7;

void* nodo1(void* x) {
    printf("1\n");
    sem_post(&sem1);
}
void* nodo1b(void* x) {
    printf("1b\n");
    sem_post(&sem1b);
}
void* nodo2(void* x) {
    sem_wait(&sem1);
    sem_wait(&sem1b);
    printf("2\n");
    sem_post(&sem2);
    sem_post(&sem2);
    sem_post(&sem2);
    sem_post(&sem2);
}
void* nodo3a(void* x) {
    sem_wait(&sem2);
    printf("3a\n");
    sem_post(&sem3a);
    sem_post(&sem3a);
}
void* nodo3b(void* x) {
    sem_wait(&sem2);
    printf("3b\n");
    sem_post(&sem3b);
    sem_post(&sem3b);
}
void* nodo3c(void* x) {
    sem_wait(&sem2);
    printf("3c\n");
    sem_post(&sem3c);
}
void* nodo3d(void* x) {
    sem_wait(&sem2);
    printf("3d\n");
    sem_post(&sem3d);
}
void* nodo4(void* x) {
    sem_wait(&sem3a);
    printf("4\n");
    sem_post(&sem4);
}
void* nodo5a(void* x) {
    sem_wait(&sem3a);
    sem_wait(&sem3b);
    printf("5a\n");
    sem_post(&sem5a);
}
void* nodo5b(void* x) {
    sem_wait(&sem3b);
    sem_wait(&sem3c);
    printf("5b\n");
    sem_post(&sem5b);
}
void* nodo5c(void* x) {
    sem_wait(&sem3d);
    printf("5c\n");
    sem_post(&sem5c);
}
void* nodo6(void* x) {
    sem_wait(&sem4);
    sem_wait(&sem5a);
    sem_wait(&sem5b);
    sem_wait(&sem5c);
    printf("6\n");
    sem_post(&sem6);
}
void* nodo7(void* x) {
    sem_wait(&sem6);
    printf("7\n");
}

int main() {
    sem_init(&sem1, 0, 0);
    sem_init(&sem1b, 0, 0);
    sem_init(&sem2, 0, 0);
    sem_init(&sem3a, 0, 0);
    sem_init(&sem3b, 0, 0);
    sem_init(&sem3c, 0, 0);
    sem_init(&sem3d, 0, 0);
    sem_init(&sem4, 0, 0);
    sem_init(&sem5a, 0, 0);
    sem_init(&sem5b, 0, 0);
    sem_init(&sem5c, 0, 0);
    sem_init(&sem6, 0, 0);
    sem_init(&sem7, 0, 0);

    pthread_t uno, unoB, dos, tresA, tresB, tresC, tresD, cuatro, cincoA, cincoB, cincoC, seis, siete;
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    
    pthread_create(&uno, &attr, nodo1, NULL);
    pthread_create(&unoB, &attr, nodo1b, NULL);
    pthread_create(&dos, &attr, nodo2, NULL);
    pthread_create(&tresA, &attr, nodo3a, NULL);
    pthread_create(&tresB, &attr, nodo3b, NULL);
    pthread_create(&tresC, &attr, nodo3c, NULL);
    pthread_create(&tresD, &attr, nodo3d, NULL);
    pthread_create(&cuatro, &attr, nodo4, NULL);
    pthread_create(&cincoA, &attr, nodo5a, NULL);
    pthread_create(&cincoB, &attr, nodo5b, NULL);
    pthread_create(&cincoC, &attr, nodo5c, NULL);
    pthread_create(&seis, &attr, nodo6, NULL);
    pthread_create(&siete, &attr, nodo7, NULL);

    pthread_join(uno, NULL);
    pthread_join(unoB, NULL);
    pthread_join(dos, NULL);
    pthread_join(tresA, NULL);
    pthread_join(tresB, NULL);
    pthread_join(tresC, NULL);
    pthread_join(tresD, NULL);
    pthread_join(cuatro, NULL);
    pthread_join(cincoA, NULL);
    pthread_join(cincoB, NULL);
    pthread_join(cincoC, NULL);
    pthread_join(seis, NULL);
    pthread_join(siete, NULL);

    return 0;
}
